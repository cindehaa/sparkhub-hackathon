// Generates a random image from Unsplash API based on the keyword passed to it

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sparkhub_app/backend/apikey/apikey.dart';


Future<String> fetchRandomImage(String keyword) async {
  final response = await http.get(
    Uri.parse('https://api.unsplash.com/photos/random?query=$keyword'),
    headers: {
      'Authorization': 'Client-ID $unsplashAccessKey',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final imageUrl = data['urls']['regular'];
    return imageUrl;
  } else {
    throw Exception('Failed to fetch image');
  }
}