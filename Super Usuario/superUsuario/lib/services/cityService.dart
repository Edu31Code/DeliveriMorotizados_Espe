import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prowess_app/models/cityModel.dart';

class CityService {
  CityService();

  Future<List<City>> getCities() async =>
      rootBundle.loadString("assets/data/coordinates.json").then((data) {
        List<City> items = [];
        List<dynamic> jsonList = json.decode(data);
        for (var item in jsonList) {
          final type = new City.fromJson(item);
          items.add(type);
        }
        return items;
      });
}
