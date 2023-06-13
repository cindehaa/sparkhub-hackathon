// The item card for each listing on the buy screen

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/screens/new_listing_screen.dart';
import 'package:sparkhub_app/utils/card_image.dart';

class ItemCard extends StatelessWidget {
  final listing_model listingObj;

  const ItemCard({Key? key, required this.listingObj}) : super(key: key);

// will be replaced by the title of the item card
// tomato for now because why not
  final String keyword = 'farmers market';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewListingScreen(
                  listingObj: listingObj,
                )));
      },
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            Image.memory(listingObj.image!.first),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(listingObj.produceName!),
                Text('\$${listingObj.unitPrice} ${listingObj.priceType}'),
              ],
            ),
            Text('${listingObj.category}'),
          ],
        ),
      ),
    );

    // return FutureBuilder(
    //   future: fetchRandomImage(keyword),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return CircularProgressIndicator();
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       final imageUrl = snapshot.data as String;
    //       return Card(
    //         child: CachedNetworkImage(
    //           imageUrl: imageUrl,
    //           placeholder: (context, url) => CircularProgressIndicator(),
    //           errorWidget: (context, url, error) => Icon(Icons.error),
    //           fit: BoxFit.cover,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
