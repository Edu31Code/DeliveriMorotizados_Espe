import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowess_app/models/pedidoModel.dart';
import 'package:prowess_app/pages/mapPage.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'package:intl/intl.dart';
import 'package:prowess_app/widgets/Card/detalleCard.dart';
import 'package:prowess_app/widgets/Card/orderCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prowess_app/services/pedidosService.dart';

class OrderInfo extends StatefulWidget {
  OrderInfo({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  PedidosService actualizarPedido = PedidosService();

  int _currentStep = 0;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat timeFormat = DateFormat("HH:mm:ss");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Constants.WHITE,
          title: Text("Informacion del Pedido",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
      body: Container(
        child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            },
            physics: ScrollPhysics(),
            currentStep: _currentStep,
            onStepContinue: () {
              // ignore: unnecessary_statements
              _currentStep < 2 ? setState(() => _currentStep += 1) : null;
            },
            onStepCancel: () {
              // ignore: unnecessary_statements
              _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
            },
            type: StepperType.horizontal,
            steps: <Step>[
              //COMPRADOR
              Step(
                title: Icon(
                  Icons.person,
                  color: Colors.pink,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pedido Nº ' + widget.pedido.numPedido!,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 25.0,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today),
                            Text(dateFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_sharp),
                            Text(timeFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Comprador",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: Constants.WHITE,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 2.0, color: Colors.grey)),
                      child: Column(
                        children: [
                          Text("Nombre:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.comprador!.nombre!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Ciudad:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.comprador!.ciudad!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Télefono:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          TextButton(
                            onPressed: () {
                              _makingPhoneCall(widget.pedido.comprador!.phone!);
                            },
                            child: Text(widget.pedido.comprador!.phone!,
                                style: GoogleFonts.robotoSlab(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                )),
                          ),
                          Text("Dirección:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.comprador!.dir1!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Referencia:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.comprador!.dir2!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              //VENDEDOR
              Step(
                title: Icon(Icons.person, color: Colors.orange),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pedido Nº ' + widget.pedido.numPedido!,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 25.0,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today),
                            Text(dateFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_sharp),
                            Text(timeFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Vendedor",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: Constants.WHITE,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 2.0, color: Colors.grey)),
                      child: Column(
                        children: [
                          Text("Nombre:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.vendedor!.nombre!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nombre de la tienda:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.vendedor!.nombreTienda!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Ciudad:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.vendedor!.ciudad!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Télefono:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          TextButton(
                            onPressed: () {
                              _makingPhoneCall(widget.pedido.vendedor!.phone!);
                            },
                            child: Text(widget.pedido.vendedor!.phone!,
                                style: GoogleFonts.robotoSlab(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                )),
                          ),
                          Text("Dirección:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Calle 1 -> " +
                                      widget.pedido.vendedor!.calle1!,
                                  style: GoogleFonts.robotoSlab(
                                    color: Constants.BLACK,
                                    fontSize: 15.0,
                                  )),
                              Text(
                                  "Calle 2 -> " +
                                      widget.pedido.vendedor!.calle2!,
                                  style: GoogleFonts.robotoSlab(
                                    color: Constants.BLACK,
                                    fontSize: 15.0,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("URL:",
                              style: GoogleFonts.robotoSlab(
                                color: Constants.VINTAGE,
                                fontSize: 15.0,
                              )),
                          Text("\t\t" + widget.pedido.vendedor!.url!,
                              style: GoogleFonts.robotoSlab(
                                color: Constants.BLACK,
                                fontSize: 15.0,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                isActive: _currentStep >= 1,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              //DETALLE Y PAGO
              Step(
                title: Icon(Icons.shopping_cart, color: Constants.VINTAGE),
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pedido Nº ' + widget.pedido.numPedido!,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 25.0,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today),
                            Text(dateFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_sharp),
                            Text(timeFormat.format(widget.pedido.fecha!),
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.orange,
                                  fontSize: 15.0,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Detalle",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    //card por cada detalle
                    Column(
                      children: widget.pedido.detalle!
                          .map((e) => DetalleCard(model: e))
                          .toList(),
                    ),
                    //pago
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        decoration: BoxDecoration(
                            color: Constants.WHITE,
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(width: 2.0, color: Colors.orange)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("Tipo de envio: ",
                                    style: GoogleFonts.robotoSlab(
                                      color: Constants.VINTAGE,
                                      fontSize: 15.0,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(widget.pedido.pago!.tipoDePago!,
                                    style: GoogleFonts.robotoSlab(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Costo de Envío:    " +
                                    widget.pedido.pago!.monedaSymbol! +
                                    widget.pedido.pago!.envio!,
                                style: GoogleFonts.robotoSlab(
                                  color: Constants.BLACK,
                                  fontSize: 18,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "Total:    " +
                                    widget.pedido.pago!.monedaSymbol! +
                                    widget.pedido.pago!.total!,
                                style: GoogleFonts.robotoSlab(
                                  color: Constants.BLACK,
                                  fontSize: 20.0,
                                )),
                          ],
                        )),
                    ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('¿Desea aceptar este pedido?'),
                          content:
                              Text('Pedido Nº ' + widget.pedido.numPedido!),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                String mensaje = "Ups... Pedido Asignado";
                                bool estado =
                                    await actualizarPedido.comprobarPedido(
                                        widget.pedido.documentId ?? "");
                                // orderList. _loadStore(widget.pedido.documentId);
                                if (estado) {
                                  actualizarPedido.updatePedidos(
                                      widget.pedido.documentId ?? '',
                                      "en proceso");
                                  mensaje = "Pedido Aprobado";
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Pedido Aceptado',
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
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text('Aceptar',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ))),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              mapPage(
                                                                  pedido: widget
                                                                      .pedido)));
                                                })
                                          ],
                                        );
                                      });
                                }
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'El pedido ya fue asignado',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Image.asset(
                                                "assets/images/check_warning.gif",
                                                height: 125.0,
                                                width: 125.0,
                                              ),
                                              Text(
                                                'Exitoso',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Aceptar',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderCard(
                                                                pedido: widget
                                                                    .pedido)));
                                              })
                                        ],
                                      );
                                    });
                              },
                              child: const Text('Sí'),
                            ),
                          ],
                        ),
                      ),
                      child: Text("Aceptar",
                          style: GoogleFonts.robotoSlab(
                            color: Constants.BLACK,
                            fontSize: 20.0,
                          )),
                    )
                  ],
                ),
                isActive: _currentStep >= 2,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              )
            ]),
      ),
    );
  }

  closeAction(BuildContext context) {
    Navigator.of(context).pop();
  }

  _makingPhoneCall(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    await launch(url.toString());
  }
}
