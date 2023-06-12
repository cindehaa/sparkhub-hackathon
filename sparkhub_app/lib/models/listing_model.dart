import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class listing_model {
  List<Uint8List>? image;
  String? description;
  String? category;
  String? priceType;
  int? unitPrice;
  String? associatedFarm;
  int? inventory;

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
      this.location});

  Map toJson() => {
        'category': category,
        'description': description,
        'inventory': inventory,
        'picture': image?.map((e) => e.toString()),
        'seller': name,
        'uid': uid,
        'unitprice': unitPrice,
        'location': location?.toJson().toString(),
      };
}
