import 'package:flutter/foundation.dart';

class listing_model {
  Uint8List? image;
  String? description;
  String? category;
  String? priceType;
  int? unitPrice;
  String? associatedFarm;
  int? inventory;

  String? uid;
  String? name;

  listing_model(
      {this.image,
      this.description,
      this.category,
      this.priceType,
      this.unitPrice,
      this.associatedFarm,
      this.inventory,
      this.uid,
      this.name});

  Map toJson() => {
        'category': category,
        'description': description,
        'inventory': inventory,
        'picture': image.toString(),
        'seller': name,
        'uid': uid,
        'unitprice': unitPrice
      };
}
