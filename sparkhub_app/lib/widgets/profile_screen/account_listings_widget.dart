import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/widgets/buy_screen/item_card.dart';

class AccountListingsWidget extends StatefulWidget {
  List<listing_model> history;

  AccountListingsWidget({super.key, required this.history});

  @override
  State<AccountListingsWidget> createState() => _AccountListingsWidgetState();
}

class _AccountListingsWidgetState extends State<AccountListingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Listings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
