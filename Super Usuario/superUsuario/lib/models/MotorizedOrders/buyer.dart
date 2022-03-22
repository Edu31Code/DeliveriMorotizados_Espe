import 'dart:convert';

Buyer ordersFromJson(String str) => Buyer.fromJson(json.decode(str));

String ordersToJson(Buyer data) => json.encode(data.toJson());

class Buyer {
  String? phone;
  String? mail;
  String? adress;
  String? id;
  String? positionLat;
  String? positionLong;
  String? name;
  String? companyName;
  String? identificationType;

  Buyer({
    this.phone,
    this.mail,
    this.adress,
    this.id,
    this.positionLat,
    this.positionLong,
    this.name,
    this.companyName,
    this.identificationType,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        phone: json["celular"],
        mail: json["correo"],
        adress: json["direccion"],
        id: json["identificacion"],
        positionLat: json["lat"],
        positionLong: json["long"],
        name: json["nombre"],
        companyName: json["razon_social"],
        identificationType: json["tipo_identificacion"],
      );

  Map<String, dynamic> toJson() => {
        "celular": phone,
        "correo": mail,
        "direccion": adress,
        "identificacion": id,
        "lat": positionLat,
        "long": positionLong,
        "nombre": name,
        "razon_social": companyName,
        "tipo_identificacion": identificationType,
      };

  fromJson(item) {}
}
