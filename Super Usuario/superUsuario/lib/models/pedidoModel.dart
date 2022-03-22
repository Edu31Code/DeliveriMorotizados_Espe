// To parse this JSON data, do
//
//     final pedido = pedidoFromJson(jsonString);

import 'dart:convert';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido(
      {this.estado,
      this.fecha,
      this.numPedido,
      this.comprador,
      this.vendedor,
      this.detalle,
      this.pago,
      this.documentId});

  String? estado;
  DateTime? fecha;
  String? numPedido;
  Comprador? comprador;
  Vendedor? vendedor;
  List<Detalle>? detalle;
  Pago? pago;
  String? documentId;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"].toDate().toString()),
        numPedido: json["num_pedido"],
        comprador: Comprador.fromJson(json["comprador"]),
        vendedor: Vendedor.fromJson(json["vendedor"]),
        detalle:
            List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
        pago: Pago.fromJson(json["pago"]),
        documentId: json["documentId"],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "fecha": fecha!.toIso8601String(),
        "num_pedido": numPedido,
        "comprador": comprador!.toJson(),
        "vendedor": vendedor!.toJson(),
        "detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
        "pago": pago!.toJson(),
        "documentId": documentId,
      };
}

class Comprador {
  Comprador({
    this.nombre,
    this.pais,
    this.ciudad,
    this.dir1,
    this.dir2,
    this.lat,
    this.long,
    this.phone,
  });

  String? nombre;
  String? pais;
  String? ciudad;
  String? dir1;
  String? dir2;
  String? lat;
  String? long;
  String? phone;

  factory Comprador.fromJson(Map<String, dynamic> json) => Comprador(
        nombre: json["nombre"],
        pais: json["pais"],
        ciudad: json["ciudad"],
        dir1: json["dir_1"],
        dir2: json["dir_2"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "pais": pais,
        "ciudad": ciudad,
        "dir_1": dir1,
        "dir_2": dir2,
        "lat": lat,
        "long": long,
        "phone": phone,
      };
}

class Detalle {
  Detalle({
    this.nombre,
    this.precio,
    this.cantidad,
    this.subtotal,
    this.taxes,
    this.total,
  });

  String? nombre;
  double? precio;
  int? cantidad;
  String? subtotal;
  String? taxes;
  String? total;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        nombre: json["nombre"],
        precio: double.parse(json["precio"].toString()),
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
        taxes: json["taxes"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
        "subtotal": subtotal,
        "taxes": taxes,
        "total": total,
      };
}

class Pago {
  Pago({
    this.tipoDePago,
    this.moneda,
    this.monedaSymbol,
    this.envio,
    this.envioTax,
    this.total,
    this.totalTax,
  });

  String? tipoDePago;
  String? moneda;
  String? monedaSymbol;
  String? envio;
  String? envioTax;
  String? total;
  String? totalTax;

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
        tipoDePago: json["tipo_de_pago"],
        moneda: json["moneda"],
        monedaSymbol: json["moneda_symbol"],
        envio: json["envio"],
        envioTax: json["envio_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
      );

  Map<String, dynamic> toJson() => {
        "tipo_de_pago": tipoDePago,
        "moneda": moneda,
        "moneda_symbol": monedaSymbol,
        "envio": envio,
        "envio_tax": envioTax,
        "total": total,
        "total_tax": totalTax,
      };
}

class Vendedor {
  Vendedor({
    this.nombre,
    this.nombreTienda,
    this.url,
    this.pais,
    this.ciudad,
    this.estado,
    this.calle1,
    this.calle2,
    this.zip,
    this.lat,
    this.long,
    this.phone,
  });

  String? nombre;
  String? nombreTienda;
  String? url;
  String? pais;
  String? ciudad;
  String? estado;
  String? calle1;
  String? calle2;
  String? zip;
  String? lat;
  String? long;
  String? phone;

  factory Vendedor.fromJson(Map<String, dynamic> json) => Vendedor(
        nombre: json["nombre"],
        nombreTienda: json["nombre_tienda"],
        url: json["url"],
        pais: json["pais"],
        ciudad: json["ciudad"],
        estado: json["estado"],
        calle1: json["calle_1"],
        calle2: json["calle_2"],
        zip: json["zip"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "nombre_tienda": nombreTienda,
        "url": url,
        "pais": pais,
        "ciudad": ciudad,
        "estado": estado,
        "calle_1": calle1,
        "calle_2": calle2,
        "zip": zip,
        "lat": lat,
        "long": long,
        "phone": phone,
      };
}
