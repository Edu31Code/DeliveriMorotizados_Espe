import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GeoReference geoReferenceFromJson(String str) =>
    GeoReference.fromJson(json.decode(str));

String geoReferenceToJson(GeoReference data) => json.encode(data.toJson());

class GeoReference {

  double lat;
  double lng;

  GeoReference({
    required this.lat,
    required this.lng,
  });

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