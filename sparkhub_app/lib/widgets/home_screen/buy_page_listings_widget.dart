import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/widgets/buy_screen/item_card.dart';

class BuyPageListings extends StatefulWidget {
  List<listing_model> history;

  BuyPageListings({super.key, required this.history});

  @override
  State<BuyPageListings> createState() => _BuyPageListingsState();
}

class _BuyPageListingsState extends State<BuyPageListings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Listings: ',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 50,
          runSpacing: 50,
          children: List.generate(
            widget.history.length,
            (index) => ItemCard(listingObj: widget.history[index]),
          ),
        ),
      ],
    );
  }
}
