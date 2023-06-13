import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sparkhub_app/models/listing_model.dart';
import 'package:sparkhub_app/widgets/buy_screen/map.dart';

final database = FirebaseDatabase.instance.ref();

class NewListingScreen extends StatefulWidget {
  final listing_model listingObj;

  const NewListingScreen({Key? key, required this.listingObj})
      : super(key: key);

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  late List<Uint8List>? fileByteList;
  int selectedImageIndex = 0;
  late int maxImages;

  @override
  void initState() {
    super.initState();
    fileByteList = widget.listingObj.image;
    maxImages = fileByteList!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
          Column(children: [
            Row(
              children: [
                //Image Selector Thingy
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (fileByteList!.asMap().containsKey(1))
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.memory(fileByteList![
                                    (selectedImageIndex + 1) % maxImages]!),
                              ),
                            if (fileByteList!.asMap().containsKey(2))
                              const SizedBox(
                                width: 50,
                                height: 10,
                              ),
                            if (fileByteList!.asMap().containsKey(2))
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.memory(fileByteList![
                                    (selectedImageIndex + 2) % maxImages]!),
                              ),
                            if (fileByteList!.asMap().containsKey(3))
                              const SizedBox(
                                width: 50,
                                height: 10,
                              ),
                            if (fileByteList!.asMap().containsKey(3))
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.memory(fileByteList![
                                    (selectedImageIndex + 3) % maxImages]!),
                              ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.memory(fileByteList![
                                  selectedImageIndex % maxImages]!),
                            ),
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
                  ],
                ),
                Column(
                  children: [
                    Text('${widget.listingObj.produceName}'),
                    Text('${widget.listingObj.associatedFarm}'),
                    Text('${widget.listingObj.description}')
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 700,
                      height: 300,
                      child: GoogleMapWidget(
                        markerPosition: widget.listingObj.location,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 400,
                      child: Container(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Text(
                                '\$${widget.listingObj.unitPrice} ${widget.listingObj.priceType}'),
                            Text('${widget.listingObj.inventory} In Stock'),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Add to cart'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ])
        ],
      ),
    );
  }
}
