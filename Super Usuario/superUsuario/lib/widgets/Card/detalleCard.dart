import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowess_app/models/pedidoModel.dart';

class DetalleCard extends StatelessWidget {
  const DetalleCard({Key? key, required this.model}) : super(key: key);
  final Detalle model;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.0, color: Colors.grey)),
        width: size.width - 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined),
                Text("Producto",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.orange,
                      fontSize: 15.0,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.nombre!,
                    style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontSize: 15.0,
                    )),
                Text("x" + model.cantidad.toString(),
                    style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontSize: 15.0,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
