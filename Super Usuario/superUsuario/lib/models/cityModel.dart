import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((value) => City.fromJson(value)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class City {
  String? nombre;
  String? provincia;
  double? longitud;
  double? latitud;
  String? habitantes;

  City({
    this.nombre,
    this.provincia,
    this.longitud,
    this.latitud,
    this.habitantes,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        nombre: json["nombre"],
        provincia: json["provincia"],
        longitud: json["longitud"].toDouble(),
        latitud: json["latitud"].toDouble(),
        habitantes: json["habitantes"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "provincia": provincia,
        "longitud": longitud,
        "latitud": latitud,
        "habitantes": habitantes,
      };
}
