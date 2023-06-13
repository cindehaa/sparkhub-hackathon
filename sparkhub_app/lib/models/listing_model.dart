import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class listing_model {
  List<Uint8List>? image;
  String? description;
  String? category;
  String? priceType;
  double? unitPrice;
  String? associatedFarm;
  int? inventory;
  String? produceName;

  String? uid;
  String? name;
  Position? location;

  listing_model(
      {this.image,
      this.description,
      this.category,
      this.priceType,
      this.unitPrice,
      this.associatedFarm,
      this.inventory,
      this.uid,
      this.name,
      this.produceName,
      this.location});

  Map toJson() => {
        'category': category,
        'description': description,
        'inventory': inventory,
        'picture': image?.map((e) => e.toString()),
        'seller': name,
        'uid': uid,
        'unitprice': unitPrice,
        'produce_name': produceName,
        'location': location?.toJson(),
      };

  listing_model fromJson(Map json) {
    final pictureList = json['picture'];
    List<Uint8List> convertedPictureList = [];
    for (final value in pictureList) {
      convertedPictureList.add(Uint8List.fromList(value.codeUnits));
    }
    return listing_model(
      category: json['category'].toString(),
      description: json['description'].toString(),
      inventory: json['inventory'],
      image: convertedPictureList,
      name: json['seller'].toString(),
      uid: json['uid'].toString(),
      unitPrice: json['unitprice'],
      produceName: json['produce_name'].toString(),
      location: Position.fromMap(json['location']),
    );
  }
}
