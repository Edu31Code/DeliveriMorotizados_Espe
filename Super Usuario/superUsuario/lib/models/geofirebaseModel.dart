import 'dart:convert';

import 'package:prowess_app/utils/enums.dart';

MapFirebase mapFirebaseFromJson(String str) =>
    MapFirebase.fromJson(json.decode(str));

String mapFirebaseToJson(MapFirebase data) => json.encode(data.toJson());

class MapFirebase {
  MapFirebase(
      {this.category,
      this.code,
      this.description,
      this.image,
      this.name,
      this.price,
      this.quantity,
      this.georeference});

  String? category;
  String? code;
  String? description;
  String? image;
  String? name;
  int? price;
  int? quantity;
  GeoReference? georeference;

  factory MapFirebase.fromJson(Map<String, dynamic> json) => MapFirebase(
      category: json["category"],
      code: json["code"],
      description: json["description"],
      image: json["image"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      georeference: json["georeference"] == null
          ? null
          : GeoReference.fromJson(json["georeference"]));

  Map<String, dynamic> toJson() => {
        "category": category,
        "code": code,
        "description": description,
        "image": image,
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}
