import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

GeoReference geoReferenceFromJson(String str) =>
    GeoReference.fromJson(json.decode(str));

String geoReferenceToJson(GeoReference data) => json.encode(data.toJson());

class GeoReference {
  GeoReference({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory GeoReference.fromJson(Map<String, dynamic> json) => GeoReference(
        lat: json["_latitude"],
        lng: json["_longitude"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  LatLng getGeo() {
    return LatLng(lat, lng);
  }
}

class ItemMenu {
  String label;
  Icon icon;
  ItemMenu(this.icon, this.label);
  ItemMenu.create(this.icon, this.label);
}

List<ItemMenu> menuOptions = [
  ItemMenu(
      Icon(
        Icons.home,
        color: Colors.grey,
      ),
      "Inicio"),
  ItemMenu(
      Icon(
        Icons.format_list_numbered,
        color: Colors.grey,
      ),
      "Tu lista"),
  ItemMenu(
      Icon(
        Icons.map,
        color: Colors.grey,
      ),
      "Mapa"),
  ItemMenu(
      Icon(
        Icons.account_box_outlined,
        color: Colors.grey,
      ),
      "Cuenta")
];

List<Widget> contentWidget = [];

class BackgroundPage {
  static Widget getBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.pink,
      ),
    );

    final circle_2 = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.red,
      ),
    );

    return Stack(
      children: [
        Container(
            height: size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            )),
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, left: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle_2),
        Positioned(bottom: 120.0, right: 20.0, child: circle_2),
        Positioned(bottom: -50.0, left: -20.0, child: circle_2),
      ],
    );
  }
}
