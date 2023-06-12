import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sparkhub_app/models/listing_model.dart';

final database = FirebaseDatabase.instance.ref();
FirebaseAuth auth = FirebaseAuth.instance;
User? currentUser = auth.currentUser;

List<String> categories = <String>[
  'fruit',
  'vegetable',
  'dairy',
  'poultry',
  'other'
];

class CreateListingForm extends StatefulWidget {
  const CreateListingForm({super.key});

  @override
  State<CreateListingForm> createState() => _CreateListingFormState();
}

class _CreateListingFormState extends State<CreateListingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Uint8List? imageBytes;
  String categoryValue = categories.first;
  listing_model listing = listing_model();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'Please upload an image';
                  } else if (value == 'TOO_MANY_FILES') {
                    return 'Please upload up to a maximum of 3 images';
                  }
                  return null;
                },
                onSaved: (value) {
                  listing.image =
                      Uint8List.fromList(value.toString().codeUnits);
                },
                builder: (formState) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: true,
                          );
                          if (result != null) {
                            List<Uint8List?> fileByteList =
                                result.files.map((e) => e.bytes).toList();
                            if (fileByteList.length <= 3) {
                              formState.didChange(fileByteList);
                              imageBytes = fileByteList.first;
                            } else {
                              formState.didChange('TOO_MANY_FILES');
                            }
                          }
                        },
                        child: formState.value == null
                            ? const Icon(Icons.upload)
                            : Image.memory(imageBytes!),
                      ),
                      if (formState.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Text(
                            formState.errorText!,
                            style: Theme.of(context)
                                .inputDecorationTheme
                                .errorStyle,
                          ),
                        )
                    ],
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter a description',
                ),
                onSaved: (value) {
                  listing.description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: categoryValue,
                items: categories.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onSaved: (value) {
                  listing.category = value;
                },
                onChanged: (value) {
                  setState(() {
                    categoryValue = value!;
                  });
                },
              ),
              DropdownButtonFormField(
                value: 'per unit',
                items: const [
                  DropdownMenuItem(
                    value: 'per unit',
                    child: Text(' per unit'),
                  ),
                  DropdownMenuItem(
                    value: 'per pound',
                    child: Text('per pound'),
                  )
                ],
                onSaved: (value) {
                  listing.priceType = value;
                },
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter a unit price',
                ),
                onSaved: (value) {
                  listing.unitPrice = int.parse(value!);
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Please enter a unit price';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your associated farm',
                ),
                onSaved: (value) {
                  listing.associatedFarm = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your associated farm';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your inventory amount',
                ),
                onSaved: (value) {
                  listing.inventory = int.parse(value!);
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Please enter your inventory amount';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    listing.uid = currentUser?.uid;
                    final snapshot = await database
                        .child('userProfiles')
                        .child('${currentUser?.uid}')
                        .child('name')
                        .get();
                    listing.name = snapshot.value.toString();
                    String? newKey =
                        await database.child('listings').push().key;
                    database
                        .child('listings')
                        .child(newKey!)
                        .set(listing.toJson());
                    database
                        .child(
                            'userProfiles/${currentUser?.uid}/userListings/${DateTime.now().microsecondsSinceEpoch}')
                        .set(newKey);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
