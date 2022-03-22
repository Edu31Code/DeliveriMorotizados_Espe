import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowess_app/components/modalComponent.dart';
import 'package:prowess_app/services/ordersMoto.dart';
import 'package:prowess_app/components/historialCardComponent.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class HistorialCard extends StatelessWidget {
  const HistorialCard({Key? key, required this.ordersMoto}) : super(key: key);
  final OrdersMoto ordersMoto;

  @override
  Widget build(BuildContext context) {
    return HistorialCardComponent(
        /*onTap: () {
        openModal(
            context,
            ordersMoto.id.toString(),
            ordersMoto.billing_address!.firstName.toString() +
                " " +
                ordersMoto.billing_address!.lastName.toString(),
            ordersMoto.billing_address!.address1.toString(),
            ordersMoto.billing_address!.phone.toString());
      },
      child: getContent(
          ordersMoto.id.toString(),
          ordersMoto.billing_address!.firstName.toString() +
              " " +
              ordersMoto.billing_address!.lastName.toString(),
          ordersMoto.billing_address!.address1.toString()),*/
        );
  }

  Widget getContent(id, name, address) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Constants.WHITE,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 2.0, color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(name,
                style: GoogleFonts.robotoSlab(
                  color: Constants.BLACK,
                  fontSize: 20.0,
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.pink),
                Text('Dirección',
                    style: GoogleFonts.robotoSlab(
                      color: Colors.grey,
                      fontSize: 12.0,
                    )),
              ],
            ),
            Text(address,
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

  Widget getData(id, name, adress, number) {
    return Container(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(" Pedido",
                style: GoogleFonts.robotoSlab(
                  color: Constants.BLACK,
                  fontSize: 20.0,
                )),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        color: Constants.VINTAGE, size: 25),
                    Text("Nº " + id),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.person_outline,
                        color: Constants.VINTAGE, size: 25),
                    Text(name),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Constants.VINTAGE, size: 25),
                    Text(adress),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.phone_android,
                        color: Constants.VINTAGE, size: 25),
                    Text(number),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  openModal(BuildContext context, title, subtitle, address, number) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ModalComponent(
            body: HistorialCardComponent(
              color: Constants.WHITE,
              child: Stack(
                children: [
                  SizedBox(
                    height: 100.0,
                    //width: MediaQuery.of(context).size.width / 2,
                    //child: Text("el sized"),
                  ),
                  getData(title, subtitle, address, number),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: TextButton(
                        onPressed: () {
                          closeAction(context);
                        },
                        child: new Icon(Icons.close),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: TextButton(
                          onPressed: () {
                            //agreeAction(context);
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(width: 2.0, color: Colors.grey)),
                            child: Text("Aceptar",
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.green,
                                  fontSize: 15.0,
                                )),
                          )))
                ],
              ),
            ),
          );
        });
  }

  closeAction(BuildContext context) {
    Navigator.of(context).pop();
  }

  /*agreeAction(BuildContext context) async {
    OrdersMoto service = OrdersMoto();
    await service.updatePackages("lP0jLgeqwXTYTanF2hWJ", this.ordersMoto);
    closeAction(context);
  }*/
}
