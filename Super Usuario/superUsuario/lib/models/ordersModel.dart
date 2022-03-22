import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  String? orderId;
  String? parentId;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  String? numItemsSold;
  String? totalSales;
  String? taxTotal;
  String? shippingTotal;
  String? netTotal;
  String? returningCustomer;
  String? status;
  String? customerId;
  
  Orders({
    this.orderId,
    this.parentId,
    this.dateCreated,
    this.dateCreatedGmt,
    this.numItemsSold,
    this.totalSales,
    this.taxTotal,
    this.shippingTotal,
    this.netTotal,
    this.returningCustomer,
    this.status,
    this.customerId,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["order_id"],
        parentId: json["parent_id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        numItemsSold: json["num_items_sold"],
        totalSales: json["total_sales"],
        taxTotal: json["tax_total"],
        shippingTotal: json["shipping_total"],
        netTotal: json["net_total"],
        returningCustomer: json["returning_customer"],
        status: json["status"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "parent_id": parentId,
        "date_created": dateCreated!.toIso8601String(),
        "date_created_gmt": dateCreatedGmt!.toIso8601String(),
        "num_items_sold": numItemsSold,
        "total_sales": totalSales,
        "tax_total": taxTotal,
        "shipping_total": shippingTotal,
        "net_total": netTotal,
        "returning_customer": returningCustomer,
        "status": status,
        "customer_id": customerId,
      };

  fromJson(item) {}
}
