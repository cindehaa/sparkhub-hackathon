import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class listing_model {
  List<Uint8List>? image;
  String? description;
  String? category;
  String? priceType;
  int? unitPrice;
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
        'location': location?.toJson().toString(),
      };
}
