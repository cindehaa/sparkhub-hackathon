import 'package:flutter/material.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/utils/retrive_user_listing.dart';
import 'package:sparkhub_app/widgets/home_screen/buy_page_listings_widget.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  late Future<List<listing_model>> listings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listings = retrieveAllListingsInFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                      child: FutureBuilder(
                    future: listings,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        case ConnectionState.done:
                          return BuyPageListings(history: snapshot.data!);
                        default:
                          return const Text('There are no listings');
                      }
                    },
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
