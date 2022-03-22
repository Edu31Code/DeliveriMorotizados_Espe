import 'dart:convert';
import 'package:prowess_app/models/MotorizedOrders/buyer.dart';
import 'package:prowess_app/models/MotorizedOrders/seller.dart';

MotorizedOrders packageFromJson(String str) =>
    MotorizedOrders.fromJson(json.decode(str));
String packageToJson(MotorizedOrders data) => json.encode(data.toJson());

class MotorizedOrders {
  String? codMotorized;
  String? status;
  String? orderNumber;
  // ignore: non_constant_identifier_names
  Buyer? buyer;
  Seller? seller;

  // ignore: non_constant_identifier_names
  MotorizedOrders(
      {this.codMotorized = "",
      this.status = "",
      this.orderNumber = "",
      this.buyer,
      this.seller});

  factory MotorizedOrders.fromJson(Map<String, dynamic> json) =>
      MotorizedOrders(
          codMotorized: json["cod_motorized"],
          status: json["estado"],
          orderNumber: json["num_pedido"],
          buyer: Buyer.fromJson(json["comprador"]),
          seller: Seller.fromJson(json["vendedor"]));

  Map<String, dynamic> toJson() => {
        "cod_motorized": codMotorized,
        "estado": status,
        "num_pedido": orderNumber,
        "vendedor": buyer!.toJson(),
        "comprador": seller!.toJson(),
      };
}
