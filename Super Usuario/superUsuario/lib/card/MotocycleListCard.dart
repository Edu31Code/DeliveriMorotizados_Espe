import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/models/preregister_motocycle.dart';
import 'package:prowess_app/pages/updateMotorizado.dart';
import 'package:prowess_app/services/google_auth_api.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MotocycleCard extends StatefulWidget {
  MotocycleCard({Key? key, required this.currentMotocycle, required this.adm})
      : super(key: key);
  final Stream<QuerySnapshot> currentMotocycle;
  final bool adm;
  @override
  _MotocycleCardState createState() => _MotocycleCardState();
}

class _MotocycleCardState extends State<MotocycleCard> {
  late String us = "";

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
  }

  deleteUser(String uid) async {
    print(uid);
    try {
      var response = await http.post(
          Uri.parse(
              "https://us-central1-prowess-bike.cloudfunctions.net/app/deleteUser"),
          body: {
            "UID": uid,
          });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(3),
      child: StreamBuilder(
          stream: widget.currentMotocycle,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'));
            }
            return Container(
              child: Column(
                children: snapshot.data!.docs.map((motocycle) {
                  var motocy;
                  if (widget.adm) {
                    motocy = Motocycle.fromJson(
                        motocycle.data() as Map<String, dynamic>);
                  } else {
                    motocy = preregisterMotocycle
                        .fromJson(motocycle.data() as Map<String, dynamic>);
                  }

                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: size.width * .80,
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(width: 2.0, color: Colors.black)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5.0),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Constants.VINTAGE,
                          child: Icon(Icons.face_outlined,
                              size: 40, color: Colors.white),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              motocy.name! + ' ' + motocy.surname.toString(),
                              style: GoogleFonts.raleway(
                                  color: Constants.VINTAGE,
                                  fontSize: 18.0,
                                  textStyle:
                                      Theme.of(context).textTheme.headline4)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CI: " + motocy.id.toString(),
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    textStyle:
                                        Theme.of(context).textTheme.headline4)),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.pinkAccent),
                                Expanded(
                                    child: Text(motocy.address.toString())),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.more_horiz_outlined),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                    "Motorizado " + motocy.name.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: ListBody(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Edad: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy.age
                                                          .toString()),
                                                      Icon(Icons.person,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Teléfono: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy.phone
                                                          .toString()),
                                                      Icon(Icons.phone,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Nacionalidad: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy.nationality
                                                          .toString()),
                                                      Icon(Icons.language,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Tipo licencia: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy
                                                          .vehicle!.typeLicense
                                                          .toString()),
                                                      Icon(Icons.motorcycle,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Nº licencia: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy
                                                          .vehicle!.licence
                                                          .toString()),
                                                      Icon(Icons.motorcycle,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Nº registro: '),
                                                  Row(
                                                    children: [
                                                      Text(motocy.vehicle!
                                                          .numberRegister
                                                          .toString()),
                                                      Icon(Icons.motorcycle,
                                                          color: Constants
                                                              .VINTAGE),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      top: BorderSide(
                                          width: 0.7, color: Color(0xFF7F7F7F)),
                                    )),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        opc(motocy, widget.adm, motocycle),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                if (widget.adm) {
                                                  deleteUser(
                                                      motocy.uid.toString());
                                                }
                                                motocycle.reference.delete();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Usuario Eliminado',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/delete.gif",
                                                                height: 125.0,
                                                                width: 125.0,
                                                              ),
                                                              Text(
                                                                'Exitoso',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                      'Aceptar',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ))),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 30.0,
                                              )),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                              size: 30.0,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ));
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget opc(var motocy, bool adm, QueryDocumentSnapshot motocylce) {
    if (adm) {
      return IconButton(
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => UpdateMororizado(
                        motocycle: motocy,
                        adm: widget.adm,
                      )),
            );
          },
          icon: Icon(
            Icons.edit,
            color: Colors.blue,
            size: 30.0,
          ));
    } else {
      return IconButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Usuario Aceptado',
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
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ))),
                          onPressed: () async {
                            await _register(motocy);
                            await _sendToServer(motocy);
                            await deletMotocyle(motocy);
                            await sendEmail(motocy);
                            Navigator.pop(context);
                          })
                    ],
                  );
                });

            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Ingrese otro correo"),
                    ));

            Navigator.pop(context);
          },
          icon: Icon(
            Icons.check,
            color: Colors.blue,
            size: 30.0,
          ));
    }
  }

  Future<void> deletMotocyle(preregisterMotocycle motocy) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('preregistro_motocycle');
      QuerySnapshot pd = await reference.get();
      String docUid = "";
      for (var doc in pd.docs) {
        if (motocy.id == doc.get("id").toString()) {
          docUid = doc.id;
          break;
        }
      }
      await reference.doc(docUid).delete();
    });
  }

  Future<void> _register(preregisterMotocycle motocy) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: motocy.email.toString(),
      password: motocy.password.toString(),
    ))
        .user;
    motocy.uid = user!.uid;
  }

  Future<void> _sendToServer(preregisterMotocycle motocy) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference;
      reference = FirebaseFirestore.instance.collection('usuario');
      await reference.add({
        "uid": motocy.uid,
        "name": motocy.name,
        "surname": motocy.surname,
        "Rol": "Motorizado",
        "id": motocy.id,
        "age": motocy.age,
        "nationality": motocy.nationality,
        "address": motocy.address,
        "phone": motocy.phone,
        "vehicle": {
          "licence": motocy.vehicle!.licence,
          "type_license": motocy.vehicle!.typeLicense,
          "brand": motocy.vehicle!.brand,
          "model": motocy.vehicle!.model,
          "number_register": motocy.vehicle!.numberRegister,
          "owner": motocy.vehicle!.owner
        }
      });
    });
  }

  Future sendEmail(preregisterMotocycle motocy) async {
    final user = await GoogleAuthApi.signIn();

    if (user == null) return;

    final email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken!;

    print('Authenticated: $email');

    final smtpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..from = Address(email, 'Total Prowess')
      ..recipients = ['$motocy.email']
      ..subject = 'Solicitud Total Prowess'
      ..html =
          '<h1>Bienvenido $motocy.name !</h1>\n<p>$motocy.name te informamos que tu solicitud de trabajo como repartidor motorizado de nuestra empresa Total Prowess a sido aceptada, por lo que puedes ya ingresar a nuestra aplicación y observar lo que tenemos para ti.</p>';
    //..text = 'Te informamos que tu solicitud de trabajo como repartidor motorizado de nuestra empresa Total Prowess a sido aceptada, por lo que puedes ya ingresar a nuestra aplicación y observar lo que tenemos para ti.';

    try {
      await send(message, smtpServer);
      showSnackBar('Correo enviado!');
    } on MailerException catch (e) {
      print(e);
    }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
