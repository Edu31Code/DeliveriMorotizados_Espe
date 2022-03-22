import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/pages/AdminPage.dart';
import 'package:prowess_app/pages/mainPage.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';

import 'RegisterPageMotocycle.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
late bool _visible = true;
late bool _valid = false;

class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);
  final BuildContext _context;

  /// The scaffold of current context.
  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  /// Helper method to show a SnackBar.
  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User? user;
  late Map<String, dynamic> roles;
  @override
  void initState() {
    _auth.userChanges().listen(
          (event) => setState(() => user = event),
        );
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            padding: const EdgeInsets.all(2),
            children: <Widget>[
              SafeArea(child: Container(height: 30.0)),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  if (!isKeyboard) _showImage(),
                  Container(
                    width: 335.0,
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(children: [
                    if (!isKeyboard)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Inicio de sesión',
                            style: Theme.of(context).textTheme.headline3),
                      ),
                    SizedBox(height: 25.0),
                    const _EmailPasswordForm(),
                  ])),
            ],
          );
        },
      ),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  const _EmailPasswordForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.BORDER_RADIOUS)),
                margin: EdgeInsets.only(left: 12, right: 12),
                elevation: Constants.ELEVATION,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.email,
                              color: Theme.of(context).primaryColorDark),
                          hintText: 'usuario@gmail.com',
                          labelText: 'Correo electrónico o usuario',
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty)
                            return 'Por favor ingrese un texto';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.BORDER_RADIOUS)),
                margin: EdgeInsets.only(left: 15, right: 15),
                elevation: Constants.ELEVATION,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscuringCharacter: "*",
                        obscureText: _visible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.lock_outline,
                              color: Theme.of(context).primaryColorDark),
                          labelText: 'Contraseña',
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty)
                            return 'Por favor ingrese un texto';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                forgetPassword(context),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: MaterialButton(
                      height: 10,
                      minWidth: 10,
                      child: Icon((_visible == false)
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                      textTheme: ButtonTextTheme.normal,
                      onPressed: () async {
                        if (_valid) {
                          setState(() {
                            _visible = true;
                          });
                          _valid = false;
                        } else {
                          setState(() {
                            _visible = false;
                          });
                          _valid = true;
                        }
                      }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: MaterialButton(
                      minWidth: 300,
                      height: 50,
                      color: Constants.VINTAGE,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Constants.BORDER_RADIOUS)),
                      child: Column(
                        children: [
                          Text(
                            'INGRESAR',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _signInWithEmailAndPassword();
                        }
                      },
                    ),
                    //),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: MaterialButton(
                      minWidth: 300,
                      height: 50,
                      color: Constants.VINTAGE,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Constants.BORDER_RADIOUS)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPageMotocycle(
                                      adm: false,
                                    )));
                      },
                      child: Text(
                        "Deseo trabajar aquí",
                        style: TextStyle(color: Constants.WHITE),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      ///),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user!;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance
          .collection("usuario")
          .where("uid", isEqualTo: userId)
          .get()
          .then((value) => {
                value.docs.forEach((result) {
                  var sections = result.get("Rol");
                  print(sections);
                  if (sections == "Admin") {
                    adminRol();
                    ScaffoldSnackbar.of(context)
                        .show('${user.email} Bienvenido Administrador');
                  } else if (sections == "Motorizado") {
                    Motocycle doc = Motocycle.fromJson(result.data());
                    motocycleRol(doc);
                    ScaffoldSnackbar.of(context)
                        .show('${user.email} Bienvenido Usuario');
                  } else {
                    ScaffoldSnackbar.of(context)
                        .show('${user.email} Bienvenido Usuario');
                  }
                  print(result.data());
                })
              });
    } catch (e) {
      ScaffoldSnackbar.of(context)
          .show('Error al iniciar sesión con correo electrónico y contraseña');
    }
  }

  Future<dynamic> adminRol() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminPage()));
  }

//A TRAVÉS DEL UID HACER UNA CONSULTA Y PASAR COMO PARÁMETRO EL MOTOCYCLE
  Future<dynamic> motocycleRol(Motocycle motocycle) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(
                  titulo: "Motorizado",
                  motocycle: motocycle,
                )));
  }
}

class EmailTextControl extends StatelessWidget {
  const EmailTextControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.email,
                      color: Theme.of(context).primaryColorDark),
                  hintText: 'usuario@gmail.com',
                  labelText: 'Correo electrónico o usuario',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) return 'Ingrese un correo válido';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordTextControl extends StatelessWidget {
  const PasswordTextControl({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(' ')),
                ],
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.lock_outline,
                      color: Theme.of(context).primaryColorDark),
                  labelText: 'Contraseña',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) return 'Ingrese una contraseña válida';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordTextControl extends StatelessWidget {
  const ConfirmPasswordTextControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.lock_outline,
                    color: Theme.of(context).primaryColorDark),
                labelText: 'Confirmar Contraseña',
                errorText: snapshot.error?.toString()),
          ),
        );
      },
    );
  }
}

class ChangeButtonControl extends StatelessWidget {
  const ChangeButtonControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
          color: Constants.VINTAGE,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 16.0),
            child: Text(
              'Cambiar',
              style: TextStyle(color: Constants.WHITE),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS)),
        );
      },
    );
  }
}

class SearchButtonControl extends StatelessWidget {
  const SearchButtonControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
          color: Constants.VINTAGE,
          onPressed: () {
            Navigator.of(context).pop();
            newPasswordPopUp(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 16.0),
            child: Text(
              'Buscar',
              style: TextStyle(color: Constants.WHITE),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS)),
        );
      },
    );
  }
}

_showImage() {
  return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: Constants.VINTAGE),
      child: ClipOval(
          child: Icon(
        Icons.person,
        color: Constants.WHITE,
        size: 50,
      )));
}

recoverPassword(BuildContext context) {
  return MaterialButton(onPressed: () {
    newPasswordPopUp(context);
  });
}

forgetPassword(BuildContext context) {
  return MaterialButton(
      onPressed: () {
        openPopUp(context);
      },
      child: Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(color: Constants.VINTAGE),
      ));
}

void openPopUp(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
            body: new Stack(
              children: [
                new Center(
                  child: new ClipRect(
                    child: new BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: new BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.1)),
                          child: new Center(
                            child: new SizedBox(
                              child: Card(
                                margin: EdgeInsets.all(50.0),
                                color: Colors.white,
                                elevation: Constants.BORDER_RADIOUS,
                                child: Column(
                                  children: [
                                    SafeArea(child: Container(height: 25)),
                                    SizedBox(height: 60.0),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        _showImage(),
                                        Container(
                                          width: 325.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text('Ingresa tu correo:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                        SizedBox(height: 25.0),
                                        Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Constants
                                                            .BORDER_RADIOUS)),
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15),
                                            elevation: Constants.ELEVATION,
                                            child: Column(
                                              children: [
                                                EmailTextControl(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        recoverPassword(context),
                                        SizedBox(height: 40.0),
                                        SearchButtonControl(),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ));
      });
}

void newPasswordPopUp(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
            body: new Stack(
              children: [
                new Center(
                  child: new ClipRect(
                    child: new BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: new Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: new BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.1)),
                          child: new Center(
                            child: new SizedBox(
                              child: Card(
                                margin: EdgeInsets.all(50.0),
                                color: Colors.white,
                                elevation: Constants.BORDER_RADIOUS,
                                child: Column(
                                  children: [
                                    SafeArea(child: Container(height: 25)),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        _showImage(),
                                        Container(
                                          width: 325.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text('Nueva Contraseña',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                        SizedBox(height: 40.0),
                                        Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Constants
                                                            .BORDER_RADIOUS)),
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15),
                                            elevation: Constants.ELEVATION,
                                            child: Column(
                                              children: [
                                                PasswordTextControl(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 40.0),
                                        Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Constants
                                                            .BORDER_RADIOUS)),
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15),
                                            elevation: Constants.ELEVATION,
                                            child: Column(
                                              children: [
                                                ConfirmPasswordTextControl(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60.0),
                                        ChangeButtonControl(),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ));
      });
}
