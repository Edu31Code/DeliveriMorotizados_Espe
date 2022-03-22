import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowess_app/components/orderCardComponent.dart';
import 'package:prowess_app/models/pedidoModel.dart';
import 'package:prowess_app/pages/orderInfPage.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    return OrderCardComponent(
      onTap: () {
        pedido.estado == "libre"
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderInfo(
                          pedido: pedido,
                        )))
            // ignore: unnecessary_statements
            : null;
      },
      child: getContent(pedido.numPedido, pedido.comprador!.nombre,
          pedido.comprador!.dir1, pedido.estado),
    );
  }

  Widget getContent(id, name, address, estado) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      decoration: BoxDecoration(
          color: Constants.WHITE,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 2.0, color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SizedBox(
                height: 15,
              ),
              Text(name = subString(name),
                  style: GoogleFonts.robotoSlab(
                    color: Constants.BLACK,
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 10,
                width: 0,
              ),
            ]),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.pink),
                Align(
                  child: Text('Dirección',
                      style: GoogleFonts.robotoSlab(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
            Text(subString(address),
                style: GoogleFonts.robotoSlab(
                  color: Colors.grey[700],
                  fontSize: 13.0,
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Constants.WHITE,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      width: 1.0,
                      color: estado == 'libre'
                          ? Colors.greenAccent
                          : Colors.orange)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.circle,
                      size: 10,
                      color: estado == 'libre'
                          ? Colors.greenAccent
                          : Colors.orange),
                  estado == 'libre' ? Text(" Libre") : Text(" En Proceso")
                ],
              ),
            ),
            Text("Nº " + id,
                style: GoogleFonts.robotoSlab(
                  color: Constants.VINTAGE,
                  fontSize: 25.0,
                )),
            Row(
              children: [
                Icon(Icons.shopping_cart_outlined, color: Colors.pink),
                Text("Pedido",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.grey,
                      fontSize: 12.0,
                    )),
              ],
            ),
          ],
        )
      ]),
    );
  }

  closeAction(BuildContext context) {
    Navigator.of(context).pop();
  }

  String subString(String nombre) {
    String str;
    try {
      str = nombre.substring(0, 20);
      return str;
    } catch (e) {
      print(e);
      return nombre;
    }
  }
}
