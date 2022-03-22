// To parse this JSON data, do
//
//     final motocycle = motocycleFromJson(jsonString);

import 'dart:convert';

import 'vehicleModel.dart';

Motocycle motocycleFromJson(String str) => Motocycle.fromJson(json.decode(str));

String motocycleToJson(Motocycle data) => json.encode(data.toJson());

class Motocycle {
  Motocycle(
      {this.rol,
      this.address,
      this.age,
      this.id,
      this.name,
      this.nationality,
      this.phone,
      this.surname,
      this.uid,
      this.urlimage,
      this.vehicle});

  String? rol;
  String? address;
  String? age;
  String? id;
  String? name;
  String? nationality;
  String? phone;
  String? surname;
  String? uid;
  String? urlimage;
  Vehicle? vehicle;

  factory Motocycle.fromJson(Map<String, dynamic> json) => Motocycle(
        rol: json["Rol"],
        address: json["address"],
        age: json["age"],
        id: json["id"],
        name: json["name"],
        nationality: json["nationality"],
        phone: json["phone"],
        surname: json["surname"],
        uid: json["uid"],
        urlimage: json["urlimage"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "Rol": rol,
        "address": address,
        "age": age,
        "id": id,
        "name": name,
        "nationality": nationality,
        "phone": phone,
        "surname": surname,
        "uid": uid,
        "urlimage": urlimage,
        "vehicle": vehicle!.toJson(),
      };
}
