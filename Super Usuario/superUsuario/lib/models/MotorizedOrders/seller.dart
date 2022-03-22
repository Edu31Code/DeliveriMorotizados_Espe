import 'dart:convert';

Seller ordersFromJson(String str) => Seller.fromJson(json.decode(str));

String ordersToJson(Seller data) => json.encode(data.toJson());

class Seller {
  String? name;
  String? lat;
  String? long;
  String? cell;
  
  
  Seller({
    this.name,
    this.lat,
    this.long,
    this.cell,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        name: json["nombre"],
        lat: json["lat"],
        long: json["long"],
        cell: json["celular"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": name,
        "lat": lat,
        "long": long,
        "celular": cell,
      };
}
