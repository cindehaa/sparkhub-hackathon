import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseApi extends StatefulWidget {    
    @override
    _FirebaseApiState createState() => _FirebaseApiState();
}

class _FirebaseApiState extends State<FirebaseApi> {
    final database = FirebaseDatabase.instance.ref();

    @override
    Widget build(BuildContext context) {
        
        // Writing to userProfiles child of the database
        final userProfiles = database.child('userProfiles/');
    
        return Scaffold(
            appBar: AppBar(
                title: Text('Firebase Testing'),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                        children: [
                            ElevatedButton(
                                onPressed: () {
                                    userProfiles.set({
                                        'name': 'John Doe',
                                        'email': 'joe@gmail.com'
                                    }).then((_) => print('Success!')); // happens after the call is made, could trigger the log in page
                                },
                                child: Text('Write to Database via Set'),
                            ),
                        ]
                    )
                )
            )
        );
    
    
    }
}