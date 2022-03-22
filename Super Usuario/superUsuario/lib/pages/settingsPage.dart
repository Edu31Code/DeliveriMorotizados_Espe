import 'package:flutter/material.dart';
import 'package:prowess_app/components/modalComponent.dart';
import 'package:prowess_app/components/titleComponent.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/pages/loginPages.dart';
import 'package:prowess_app/pages/updateMotorizado.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'package:prowess_app/components/buttonComponent.dart';
import 'package:prowess_app/widgets/forgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.motocycle}) : super(key: key);
  final Motocycle motocycle;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: TitleComponent(
                title: "Mi cuenta",
              ),
            ),
            SizedBox(height: 50.0),
            SizedBox(
              height: 100,
              child: Card(
                child: ListTile(
                  title: Text(
                      widget.motocycle.name! + " " + widget.motocycle.surname!),
                  subtitle: Text(_auth.currentUser!.email ?? ""),
                  leading: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      _showImage(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                child: Card(
                    child: ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text("Información de usuario"),
              //Aqui
              onTap: () {
                //Informacion de usuario falta
              },
            ))),
            SizedBox(
                child: Card(
                    child: ListTile(
                        leading: Icon(Icons.security),
                        title: Text("Cambiar contraseña"),
                        //Aqui
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ModalComponent(
                                  body: ForgetPassword(),
                                );
                              });
                        }))),
            SizedBox(
                child: Card(
                    child: ListTile(
              leading: Icon(Icons.security_update_good),
              title: Text("Actualizar Datos"),
              //Aqui
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            //Nueva pagina (numeros de telefono)
                            UpdateMororizado(
                              motocycle: widget.motocycle,
                              adm: false,
                            )));
              },
            ))),
            SizedBox(
                child: Card(
                    child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Historial de Pedidos"),
              //Aqui
              onTap: () {
                //pagina Historial
              },
            ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: ButtonComponent(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<Null>(builder: (BuildContext contex) {
                      return new LoginPage();
                    }), (Route<dynamic> route) => false);
                  },
                  text: "Cerrar Sesión",
                  width: 100.0,
                ))
          ],
        ),
      ),
    ));
  }
}

backAction(BuildContext context) {
  Navigator.pop(context);
}

_showImage() {
  var _imageSelected;
  return Container(
    width: 55.0,
    height: 130.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75.0), color: Constants.VINTAGE),
    child: ClipOval(
        child: _imageSelected == false
            ? Image.asset("assets/images/user.png")
            : null),
  );
}
