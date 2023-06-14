import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sparkhub_app/backend/apikey/apikey.dart';
import 'package:sparkhub_app/utils/NetworkHelper.dart';
import 'package:sparkhub_app/utils/getLocation.dart';

import 'package:flutter/material.dart';

class GoogleMapWidget extends StatefulWidget {
  final Position? markerPosition;
  const GoogleMapWidget({Key? key, this.markerPosition}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late Future<Position> location;

  final List<LatLng> polyPoints = [];
  final Set<Polyline> polyLines = {};

  var data;

  void getJsonData(
      double startLat, double startLng, double endLat, double endLng) async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      setPolyLines();
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
    );
    polyLines.add(polyline);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    location = determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: location,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.done:
            return GoogleMap(
              polylines: polyLines,
              mapType: MapType.normal,
              markers: <Marker>{
                if (widget.markerPosition != null)
                  Marker(
                    infoWindow: const InfoWindow(
                      title: 'Destination',
                    ),
                    markerId: MarkerId('${37.5485}, ${-121.9886}'),
                    position: LatLng(37.5485, -121.9886),
                    draggable: false,
                  ),
                Marker(
                  infoWindow: const InfoWindow(
                    title: 'Start',
                  ),
                  markerId: MarkerId('${37.7749}, ${-122.4194}'),
                  position: LatLng(37.7749, -122.4194),
                  draggable: false,
                )
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 14.7,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.moveCamera(
                  CameraUpdate.newLatLngBounds(
                    LatLngBounds(
                      northeast: LatLng(37.7749 <= 37.5485 ? 37.5485 : 37.7749,
                          -122.4194 <= -121.9886 ? -121.9886 : -122.4194),
                      southwest: LatLng(37.7749 <= 37.5485 ? 37.7749 : 37.5485,
                          -122.4194 <= -121.9886 ? -122.4194 : -121.9886),
                    ),
                    100.0,
                  ),
                );
                getJsonData(37.7749, -122.4194, 37.5485, -121.9886);
              },
            );
          default:
            return Container(
              width: 500,
              height: 500,
              color: Colors.blue,
              child: const Text('Default'),
            );
        }
      },
    );
  }
}
