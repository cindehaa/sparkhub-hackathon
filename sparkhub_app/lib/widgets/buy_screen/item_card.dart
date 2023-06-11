// The item card for each listing on the buy screen

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparkhub_app/utils/card_image.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

// tomato because why not
  final String keyword = 'tomato';


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRandomImage(keyword),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final imageUrl = snapshot.data as String;
          return Card(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
