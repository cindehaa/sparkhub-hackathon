import 'package:flutter/material.dart';
import 'package:sparkhub_app/backend/apikey/apikey.dart';
import 'package:google_maps/google_maps.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:js';


// class GoogleMapsScreen extends StatefulWidget {
//   final double listingLatitude;
//   final double listingLongitude;

//   const GoogleMapsScreen({
//     required this.listingLatitude,
//     required this.listingLongitude,
//   });

//   @override
//   _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
// }

// class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
//   String apiKey = googleMapsKey; // Get the API key from apikey.dart

//   @override
//   void initState() {
//     super.initState();
//     loadGoogleMaps();
//   }

//   void loadGoogleMaps() {
//     final script = html.ScriptElement()
//       ..async = true
//       ..defer = true
//       ..innerHtml = '''
//         function initMap() {
//           var mapProp= {
//             center: new google.maps.LatLng(${widget.listingLatitude},${widget.listingLongitude}),
//             zoom: 5,
//           };
//           var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
//         }
//         const script = document.createElement("script");
//         script.src = "https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap";
//         document.body.appendChild(script);
//       ''';

//     html.document.body!.children.add(script);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 400,
//           height: 300,
//           child: HtmlElementView(viewType: 'googleMap'),
//         ),
//       ),
//     );
//   }

// }


import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as universal_html;

class GoogleMapsScreen extends StatefulWidget {
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HtmlElementView(
        viewType: 'GoogleMapsElement',
      ),
    );
  }
}
