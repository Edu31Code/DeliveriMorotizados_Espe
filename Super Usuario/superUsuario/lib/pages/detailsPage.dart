import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowess_app/models/pedidoModel.dart';
import 'package:prowess_app/services/pedidosService.dart';
import 'package:prowess_app/widgets/Card/detalleCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.pedidos}) : super(key: key);
  final Pedido pedidos;
  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  PedidosService actualizarPedido = PedidosService();
  void launcherWhatsapp(String number, String message) async {
    String url = 'whatsapp://send?phone=$number&text=$message';
    await canLaunch(url) ? launch(url) : print('No se pudo abrir el whatsapp');
  }

  _makingPhoneCall(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    await launch(url.toString());
  }

  @override
  Widget build(BuildContext context) {
    var _pedido = FirebaseFirestore.instance
        .collection("pedidos")
        .doc(widget.pedidos.documentId)
        .get()
        .asStream();
    return Scaffold(
        backgroundColor: Constants.VINTAGE,
        appBar: AppBar(
          title: Text('Detalles del pedido'),
          shadowColor: Constants.VINTAGE,
          backgroundColor: Constants.WHITE,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _pedido,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
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
              //cambio a pedido
              Pedido pedido = Pedido.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);
              pedido.documentId = widget.pedidos.documentId;
              return SingleChildScrollView(
                child:
                    Stack(alignment: AlignmentDirectional.topCenter, children: [
                  Container(
                      margin: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Constants.WHITE,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Column(children: [
                        //CHAT CON EL CLIENTE
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "¿Cuál es el estado del Pedido?",
                            style: GoogleFonts.robotoSlab(color: Colors.teal),
                          ),
                        ),
                        Row(
                          children: [
                            //Pedido recogido
                            SizedBox(width: 30.0),
                            FloatingActionButton.extended(
                              heroTag: " boton1",
                              backgroundColor: Constants.VINTAGE,
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      '¿Desea cambiar de estado a Recogido?'),
                                  content:
                                      Text('Pedido Nº ' + pedido.numPedido!),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        actualizarPedido.updatePedidos(
                                            pedido.documentId ?? '',
                                            "recogido");
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Pedido Recogido',
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/check_solicitud.gif",
                                                        height: 125.0,
                                                        width: 125.0,
                                                      ),
                                                      Text(
                                                        'Exitoso',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text('Aceptar',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ))),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailsPage(
                                                                          pedidos:
                                                                              pedido,
                                                                        )));
                                                        setState(() {});
                                                      })
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text('Sí'),
                                    )
                                  ],
                                ),
                              ),
                              label: Text('Recogido',
                                  style: TextStyle(color: Constants.WHITE)),
                            ),
                            //Pedido en ruta
                            SizedBox(width: 10.0),
                            FloatingActionButton.extended(
                              heroTag: " boton4",
                              backgroundColor: Constants.VINTAGE,
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      '¿Desea cambiar de estado a En ruta?'),
                                  content:
                                      Text('Pedido Nº ' + pedido.numPedido!),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        actualizarPedido.updatePedidos(
                                            pedido.documentId ?? '', "en ruta");
                                        launcherWhatsapp(
                                            '+593' + pedido.comprador!.phone!,
                                            'Estoy en camino con su pedido!');
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Pedido En Ruta',
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/check_solicitud.gif",
                                                        height: 125.0,
                                                        width: 125.0,
                                                      ),
                                                      Text(
                                                        'Exitoso',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text('Aceptar',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ))),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailsPage(
                                                                          pedidos:
                                                                              pedido,
                                                                        )));
                                                        setState(() {});
                                                      })
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text('Sí'),
                                    )
                                  ],
                                ),
                              ),
                              label: Text('En ruta',
                                  style: TextStyle(color: Constants.WHITE)),
                            ),
                            //Pedido entregado
                            SizedBox(width: 10.0),
                            FloatingActionButton.extended(
                              heroTag: " boton2",
                              backgroundColor: Constants.VINTAGE,
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      '¿Desea cambiar de estado a Entregado?'),
                                  content:
                                      Text('Pedido Nº ' + pedido.numPedido!),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        actualizarPedido.updatePedidos(
                                            pedido.documentId ?? '',
                                            "Entregado");
                                        launcherWhatsapp(
                                            '+593' + pedido.comprador!.phone!,
                                            'He llegado! Su pedido esta listo');
                                        //aqui va al historial de pedidos
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Pedido Entregado',
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/check_solicitud.gif",
                                                        height: 125.0,
                                                        width: 125.0,
                                                      ),
                                                      Text(
                                                        'Exitoso',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text('Aceptar',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ))),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DetailsPage(
                                                                          pedidos:
                                                                              pedido,
                                                                        )));
                                                        setState(() {});
                                                      })
                                                ],
                                              );
                                            });
                                      },
                                      child: const Text('Sí'),
                                    )
                                  ],
                                ),
                              ),
                              label: Text('Entregado',
                                  style: TextStyle(color: Constants.WHITE)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Pedido Nº " + pedido.numPedido!,
                            style: GoogleFonts.robotoSlab(
                                color: Colors.black, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Estado: " + pedido.estado!.toUpperCase(),
                            style: GoogleFonts.robotoSlab(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constants.WHITE,
                              border:
                                  Border.all(width: 2.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Detalle",
                                    style: GoogleFonts.robotoSlab(
                                        color: Colors.black, fontSize: 20)),
                                Column(
                                  children: pedido.detalle!
                                      .map((e) => DetalleCard(model: e))
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tipo de Pago",
                                            style: GoogleFonts.robotoSlab(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 13)),
                                        Text(pedido.pago!.tipoDePago!,
                                            style: GoogleFonts.robotoSlab(
                                                color: Colors.black,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("Envio",
                                            style: GoogleFonts.robotoSlab(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 13)),
                                        Text(
                                            pedido.pago!.monedaSymbol! +
                                                pedido.pago!.envio!,
                                            style: GoogleFonts.robotoSlab(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text("Total",
                                            style: GoogleFonts.robotoSlab(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 13)),
                                        Text(
                                            pedido.pago!.monedaSymbol! +
                                                pedido.pago!.total!,
                                            style: GoogleFonts.robotoSlab(
                                                color: Colors.orange,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constants.WHITE,
                              border:
                                  Border.all(width: 2.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Comprador",
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 20)),
                                    Text("Nombre",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(pedido.comprador!.nombre!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15)),
                                    Text("Ciudad",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(pedido.comprador!.ciudad!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15)),
                                    Text("Direccion",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(
                                        pedido.comprador!.dir1! +
                                            " y " +
                                            pedido.comprador!.dir2!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15))
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          launcherWhatsapp(
                                              '+593' + pedido.comprador!.phone!,
                                              'Hola! Soy {nombre}, vengo a recoger el pedido ' +
                                                  pedido.numPedido! +
                                                  ' le espero!');
                                        },
                                        icon: Icon(
                                          Icons.messenger_outline,
                                          size: 30,
                                          color: Constants.VINTAGE,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          _makingPhoneCall(
                                              pedido.comprador!.phone!);
                                        },
                                        icon: Icon(
                                          Icons.phone,
                                          size: 30,
                                          color: Constants.VINTAGE,
                                        ))
                                  ])
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constants.WHITE,
                              border:
                                  Border.all(width: 2.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Vendedor",
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 20)),
                                    Text("Nombre",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(pedido.vendedor!.nombre!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15)),
                                    Text("Ciudad",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(pedido.vendedor!.ciudad!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15)),
                                    Text("Direccion",
                                        style: GoogleFonts.robotoSlab(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13)),
                                    Text(
                                        pedido.vendedor!.calle1! +
                                            " y " +
                                            pedido.vendedor!.calle2!,
                                        style: GoogleFonts.robotoSlab(
                                            color: Colors.black, fontSize: 15))
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          launcherWhatsapp(
                                              '+593' + pedido.vendedor!.phone!,
                                              'Hola! Soy {nombre}, vengo a recoger el pedido ' +
                                                  pedido.numPedido! +
                                                  ' le espero!');
                                        },
                                        icon: Icon(
                                          Icons.messenger_outline,
                                          size: 30,
                                          color: Constants.VINTAGE,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          _makingPhoneCall(
                                              pedido.vendedor!.phone!);
                                        },
                                        icon: Icon(
                                          Icons.phone,
                                          size: 30,
                                          color: Constants.VINTAGE,
                                        ))
                                  ])
                            ],
                          ),
                        ),
                      ]))
                ]),
              );
            }));
  }
}
