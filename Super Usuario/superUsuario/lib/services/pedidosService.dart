import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prowess_app/models/pedidoModel.dart';

class PedidosService {
  PedidosService();

  Future<List<Pedido>> getPedidos(String document) async {
    List<Pedido> result = [];
    try {
      Map<String, dynamic> user = (await FirebaseFirestore.instance
              .collection("pedidos")
              .doc(document)
              .get())
          .data() as Map<String, dynamic>;
      dynamic pedidos = user["pedidos"];
      print("Llego a service pedido");
      for (var item in pedidos) {
        final pedido = Pedido.fromJson(item);
        print(pedido);
        result.add(pedido);
      }
      return result;
    } catch (ex) {
      return result;
    }
  }

  updatePedidos(String document, String estado) async {
    /* OrdersMoto service = OrdersMoto();
      service.getPackages(document).then((value) {
      _orden.add(value[0]);
      if (mounted) {
        setState(() {});
      }
    });*/
    try {
      await FirebaseFirestore.instance
          .collection('pedidos')
          .doc(document)
          .update({
        'estado': estado,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> comprobarPedido(String pedidoId) async {
    var _pedidoSn = await FirebaseFirestore.instance
        .collection('pedidos')
        .doc(pedidoId)
        .get();
    if (_pedidoSn.get("estado") == "libre") {
      return true;
    }
    return false;
  }
}
