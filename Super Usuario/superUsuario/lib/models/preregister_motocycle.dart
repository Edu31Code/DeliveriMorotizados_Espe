// To parse this JSON data, do
//
//     final preregisterMotocycle = preregisterMotocycleFromJson(jsonString);

import 'dart:convert';

import 'package:prowess_app/models/vehicleModel.dart';

preregisterMotocycle preregisterMotocycleFromJson(String str) =>
    preregisterMotocycle.fromJson(json.decode(str));

String preregisterMotocycleToJson(preregisterMotocycle data) =>
    json.encode(data.toJson());

class preregisterMotocycle {
  preregisterMotocycle({
    this.rol,
    this.address,
    this.age,
    this.id,
    this.name,
    this.nationality,
    this.phone,
    this.surname,
    this.uid,
    this.email,
    this.password,
    this.vehicle,
  });

  String? rol;
  String? address;
  String? age;
  String? id;
  String? name;
  String? nationality;
  String? phone;
  String? surname;
  String? uid;
  String? email;
  String? password;
  Vehicle? vehicle;

  factory preregisterMotocycle.fromJson(Map<String, dynamic> json) =>
      preregisterMotocycle(
        rol: json["Rol"],
        address: json["address"],
        age: json["age"],
        id: json["id"],
        name: json["name"],
        nationality: json["nationality"],
        phone: json["phone"],
        surname: json["surname"],
        uid: json["uid"],
        email: json["email"],
        password: json["password"],
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
        "email": email,
        "password": password,
        "vehicle": vehicle!.toJson(),
      };
}
