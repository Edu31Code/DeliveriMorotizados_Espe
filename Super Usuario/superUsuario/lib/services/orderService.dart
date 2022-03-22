import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prowess_app/models/ordersModel.dart';

class OrderService {
  OrderService();

  Future<List<Orders>> getOrders() async {
    List<Orders> items = [];
    try {
      var uri = Uri.https("prowessec.com", "/api/order_stats");
      final resp = await http.get(uri);
      if (resp.body.isEmpty) return items;
      List<dynamic> jsonList = json.decode(resp.body);
      for (var item in jsonList) {
        final order = new Orders().fromJson(item);
        items.add(order);
      }
      return items;
    } catch (e) {
      print("Exception $e");
      return items;
    }
  }
}
