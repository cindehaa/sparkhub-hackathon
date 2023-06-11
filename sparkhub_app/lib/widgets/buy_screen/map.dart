import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:flutter/material.dart';
import 'package:sparkhub_app/backend/apikey/apikey.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'dart:html';
import 'dart:js';


class GoogleMapsScreen extends StatefulWidget {
  final double listingLatitude;
  final double listingLongitude;

  const GoogleMapsScreen({
    required this.listingLatitude,
    required this.listingLongitude,
  });

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  String apiKey = googleMapsKey; // Get the API key from apikey.dart

  @override
  void initState() {
    super.initState();
    loadGoogleMaps();
  }

  void loadGoogleMaps() {
    final script = html.ScriptElement()
      ..async = true
      ..defer = true
      ..innerHtml = '''
        function initMap() {
          var mapProp= {
            center: new google.maps.LatLng(51.508742,-0.120850),
            zoom: 5,
          };
          var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
        }
        const script = document.createElement("script");
        script.src = "https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap";
        document.body.appendChild(script);
      ''';

    html.document.body!.children.add(script);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 300,
          child: HtmlElementView(viewType: 'google-maps'),
        ),
      ),
    );
  }
}
