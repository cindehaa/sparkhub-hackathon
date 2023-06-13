import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  final String name;
  final String email;

  // final String test = "hi";

  // UserDetailsWidget({required this.name, required this.email});

  const UserDetailsWidget({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("called UserDetailsWidget");
    print(name);
    print(email);

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                Text(email),
              ],
            ),
          ),
          TextButton(
            child: const Text('Edit Farm'),
            onPressed: () {
              // TODO: Add your onPressed logic here
            },
          ),
          TextButton(
            child: const Text('Edit Bio'),
            onPressed: () {
              // TODO: Add your onPressed logic here
            },
          ),
        ],
      ),
    );
  }
}
