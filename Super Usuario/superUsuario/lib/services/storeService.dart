import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prowess_app/models/storesModel.dart';

class StoreService {
  StoreService();

  Future<List<Stores>> getStores() async {
    List<Stores> items = [];
    try {
      var uri = Uri.https("prowessec.com", "wp-json/dokan/v1/stores");
      final resp = await http.get(uri);
      if (resp.body.isEmpty) return items;
      List<dynamic> jsonList = json.decode(resp.body);
      for (var item in jsonList) {
        final store = new Stores.fromJson(item);
        items.add(store);
      }
      return items;
    } catch (e) {
      print("Exception $e");
      return items;
    }
  }
}
