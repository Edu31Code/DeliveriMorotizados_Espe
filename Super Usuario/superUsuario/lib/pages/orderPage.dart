import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/models/pedidoModel.dart';
import 'package:prowess_app/widgets/Card/orderCard.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.motocycle}) : super(key: key);
  final Motocycle motocycle;
  @override
  _OrderPagetState createState() => _OrderPagetState();
}

class _OrderPagetState extends State<OrderPage> {
  final Stream<QuerySnapshot> _pedidoStrem = FirebaseFirestore.instance
      .collection('pedidos')
      .orderBy('fecha', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _pedidoStrem,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            const Center(
              child: Center(child: Text("Error al consultar los pedidos")),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator()),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Pedido model =
                Pedido.fromJson(document.data() as Map<String, dynamic>);
            model.documentId = document.id;
            return OrderCard(pedido: model);
          }).toList());
        });
  }
}
