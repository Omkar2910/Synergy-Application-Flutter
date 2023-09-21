import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsUtils {
  MapsUtils._();

  //latitude longitude
  static Future<void> openMapWithPosition(
      double latitude, double longitude) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

// final Uri _url = Uri.parse('https://flutter.dev');

// void main() => runApp(
//       const MaterialApp(
//         home: Material(
//           child: Center(
//             child: ElevatedButton(
//               onPressed: _launchUrl,
//               child: Text('Show Flutter homepage'),
//             ),
//           ),
//         ),
//       ),
//     );

//     Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw 'Could not launch $_url';
//   }
// }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async {
    String query = Uri.encodeComponent(fullAddress);
    final Uri googleMapUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

    if (!await launchUrl(googleMapUrl)) {
      throw 'Could not launch $googleMapUrl';
    }
  }
}
