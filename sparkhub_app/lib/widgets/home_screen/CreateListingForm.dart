import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/utils/getLocation.dart';
import 'package:sparkhub_app/widgets/buy_screen/item_card.dart';

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
  List<Uint8List?> fileByteList = [];
  String categoryValue = categories.first;
  listing_model listing = listing_model();
  int selectedImageIndex = 0;
  int maxImages = 4;

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
              if (listing.associatedFarm != null) ItemCard(listingObj: listing),
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
                  listing.image = fileByteList.cast<Uint8List>();
                },
                builder: (formState) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          if (formState.value != null &&
                              formState.value != 'TOO_MANY_FILES')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (fileByteList.asMap().containsKey(1))
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.memory(fileByteList[
                                        (selectedImageIndex + 1) % maxImages]!),
                                  ),
                                if (fileByteList.asMap().containsKey(2))
                                  const SizedBox(
                                    width: 50,
                                    height: 10,
                                  ),
                                if (fileByteList.asMap().containsKey(2))
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.memory(fileByteList[
                                        (selectedImageIndex + 2) % maxImages]!),
                                  ),
                                if (fileByteList.asMap().containsKey(3))
                                  const SizedBox(
                                    width: 50,
                                    height: 10,
                                  ),
                                if (fileByteList.asMap().containsKey(3))
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.memory(fileByteList[
                                        (selectedImageIndex + 3) % maxImages]!),
                                  ),
                              ],
                            ),
                          Column(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: InkWell(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['png', 'jpg', 'jpeg'],
                                      allowMultiple: true,
                                    );
                                    if (result != null) {
                                      fileByteList = result.files
                                          .map((e) => e.bytes)
                                          .toList();
                                      maxImages = fileByteList.length;
                                      if (fileByteList.length <= 4) {
                                        formState.didChange(fileByteList);
                                      } else {
                                        formState.didChange('TOO_MANY_FILES');
                                      }
                                    }
                                  },
                                  child: formState.value == null ||
                                          formState.value == 'TOO_MANY_FILES'
                                      ? const Icon(Icons.upload)
                                      : Image.memory(fileByteList[
                                          selectedImageIndex % maxImages]!),
                                ),
                              ),
                              if (formState.value != null &&
                                  formState.value != 'TOO_MANY_FILES')
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedImageIndex--;
                                        });
                                      },
                                      child: const Center(
                                          child: Icon(
                                        Icons.arrow_left,
                                        size: 20,
                                      )),
                                    ),
                                    Text(
                                      '${selectedImageIndex % maxImages + 1} / $maxImages',
                                      style: const TextStyle(inherit: true),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedImageIndex++;
                                        });
                                      },
                                      child: const Center(
                                          child: Icon(
                                        Icons.arrow_right,
                                        size: 20,
                                      )),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ],
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
                  hintText: 'Enter the name of what you\'re selling',
                ),
                onSaved: (value) {
                  listing.produceName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
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
                    categoryValue = value;
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
                  listing.unitPrice = double.parse(value!);
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
                    listing.location = await determinePosition();
                    String? newKey =
                        await database.child('listings').push().key;
                    database
                        .child('listings')
                        .child(newKey!)
                        .set(listing.toJson())
                        .then((value) => {
                              database
                                  .child(
                                      'userProfiles/${currentUser?.uid}/userListings/${DateTime.now().microsecondsSinceEpoch}')
                                  .set(newKey)
                            });
                    setState(() {});
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
