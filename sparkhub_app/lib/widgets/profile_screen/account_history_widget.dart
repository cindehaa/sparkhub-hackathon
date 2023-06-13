import 'package:flutter/material.dart';

class AccountHistoryWidget extends StatelessWidget {
  final List<String> history;

  AccountHistoryWidget({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(history[index]),
            );
          },
        ),
      ],
    );
  }
}
