// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prowess_app/pages/AdminPage.dart';
import 'package:prowess_app/pages/loginPages.dart';
import 'package:prowess_app/pages/verify.dart';
import 'package:prowess_app/services/imageService.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPageMotocycle extends StatefulWidget {
  const RegisterPageMotocycle({Key? key, required this.adm}) : super(key: key);
  final bool adm;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageMotocycle> {
  late String _dropDownValue = "";
  int currentStep = 0;
  File? image;
  String? urlImagen;
  late String us = "";
  // ignore: unused_field
  late bool? _success;
  late int cont;
  late bool _visible = true;
  late bool _valid = false;
  // ignore: unused_field
  late String _userEmail = '';

  final name = TextEditingController();
  final surname = TextEditingController();
  final nationality = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();

  final age = TextEditingController();
  final docId = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final license = TextEditingController();
  final typeLicense = TextEditingController();
  final brand = TextEditingController();
  final model = TextEditingController();
  final numberRegist = TextEditingController();
  final owner = TextEditingController();
  final FotosService _fotosService = FotosService();

  List<GlobalKey<FormState>> _listKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  Future _selectImage(ImageSource source) async {
    final imageCamera = await ImagePicker().pickImage(source: source);
    if (imageCamera == null) return;
    final imageTemporary = File(imageCamera.path);
    image = imageTemporary;
    if (image != null) {
      urlImagen = await _fotosService.uploadImage(image!);
    }
    setState(() {});
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Icon(Icons.person),
          content: Form(
            key: _listKeys[0],
            autovalidateMode: AutovalidateMode.disabled,
            child: formUser1(),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Icon(Icons.contact_mail_outlined),
          content: Form(
            key: _listKeys[1],
            autovalidateMode: AutovalidateMode.disabled,
            child: formUser2(),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Icon(Icons.motorcycle),
          content: Form(
            key: _listKeys[2],
            autovalidateMode: AutovalidateMode.disabled,
            child: formMotor(),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 800,
      child: Scaffold(
        appBar: AppBar(
          title: Text((widget.adm)
              ? "Registrar Nuevo Motorizado"
              : "Registrar Nuevo Aspirante"),
          centerTitle: true,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Constants.VINTAGE),
          ),
          child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white70)),
                      onPressed: details.onStepCancel,
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white70)),
                      onPressed: details.onStepContinue,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              );
            },
            type: StepperType.vertical,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () async {
              final isLastStep = currentStep == getSteps().length - 1;
              if (_listKeys[currentStep].currentState!.validate()) {
                if (isLastStep) {
                  if (widget.adm) {
                    await _register();
                    await _sendToServer(true);
                  } else {
                    await _sendToServer(false);
                  }

                  print(
                      "_____----******************************completado****************************----_____");

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Registro Completado',
                            textAlign: TextAlign.center,
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Image.asset(
                                  "assets/images/check-correct.gif",
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Solicitud de Motorizado',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                Image.asset(
                                                  "assets/images/solicitud.gif",
                                                  height: 125.0,
                                                  width: 125.0,
                                                ),
                                                Text(
                                                  'Su solicitud se esta procesando',
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
                                                  (widget.adm)
                                                      ? Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute<Null>(builder:
                                                                  (BuildContext
                                                                      contex) {
                                                          //return new AdminPage();
                                                          return new VerifyScreen();
                                                        }),
                                                              (Route<dynamic> route) =>
                                                                  false)
                                                      : Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute<Null>(builder:
                                                                  (BuildContext
                                                                      contex) {
                                                            //return new LoginPage();
                                                            return new VerifyScreen();
                                                        }),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                })
                                          ],
                                        );
                                      });
                                })
                          ],
                        );
                      });
                } else {
                  setState(() => currentStep += 1);
                }
              }
            },
            onStepCancel: currentStep == 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  }
                : () {
                    setState(() => currentStep -= 1);
                  },
          ),
        ),
      ),
    );
  }

  Widget formUser1() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Padding(
            padding: EdgeInsets.all(11.0),
            child: Column(children: <Widget>[
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                controller: name,
                decoration: InputDecoration(
                    labelText: "Nombre",
                    prefixIcon: Icon(Icons.person_outline_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return nameValidation(value);
                  } else {
                    if (value.isEmpty) {
                      return 'No puede dejar esta casillero vacio';
                    }
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                controller: surname,
                decoration: InputDecoration(
                    labelText: "Apellido",
                    prefixIcon: Icon(Icons.person_outline_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return surnameValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                controller: nationality,
                decoration: InputDecoration(
                    labelText: "Nacionalidad",
                    prefixIcon: Icon(Icons.emoji_flags_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return nationalityValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.multiline,
                controller: address,
                decoration: InputDecoration(
                    labelText: "Ciudad de residencia",
                    prefixIcon: Icon(Icons.location_on_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return adressValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: phone,
                  decoration: InputDecoration(
                      labelText: "Celular", prefixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return phoneValidation(value);
                    } else {
                      return 'No puede dejar esta casillero vacio';
                    }
                  }),
              ListTile(
                title: Text(
                  "Seleccione Una Imagen de Perfil",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          color: Colors.black,
                          child: const Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          onPressed: () => _selectImage(ImageSource.camera)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          color: Colors.black,
                          child: const Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          onPressed: () => _selectImage(ImageSource.gallery)),
                    ),
                  ],
                ),
              ),
            ])));
  }

  Widget formUser2() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        //key: _form2Key,
        child: Padding(
            padding: EdgeInsets.all(11.0),
            child: Column(children: <Widget>[
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                controller: age,
                maxLength: 2,
                decoration: InputDecoration(
                    labelText: "Edad", prefixIcon: Icon(Icons.cake_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return ageValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                controller: docId,
                decoration: InputDecoration(
                    labelText: "Cédula",
                    prefixIcon: Icon(Icons.person_outline_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return idValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.alternate_email_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return emailValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                obscuringCharacter: "*",
                controller: password,
                decoration: InputDecoration(
                    hintText: 'Contraseña', labelText: 'Contraseña'),
                obscureText: _visible,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return passwordValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
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
                      if (_valid == false) {
                        setState(() {
                          _visible = false;
                        });
                        _valid = true;
                      } else {
                        setState(() {
                          _visible = true;
                        });
                        _valid = false;
                      }
                    }),
              ),
            ])));
  }

  Widget formMotor() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Padding(
            padding: EdgeInsets.all(11.0),
            child: Column(children: <Widget>[
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                controller: license,
                decoration: InputDecoration(
                    labelText: "Número de Licencia",
                    prefixIcon: Icon(Icons.badge_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return licenseValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ListTile(
                        title: const Text("Tipo de Licencia"),
                      )),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: DropdownButton(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      alignment: AlignmentDirectional.center,
                      menuMaxHeight: 100,
                      hint: _dropDownValue == ""
                          ? Text('Licencia')
                          : Text(
                              _dropDownValue,
                              style: TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ['A', 'A1', 'B', 'B1'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Visibility(
                    visible: false,
                    child: TextFormField(
                      enabled: false,
                      controller: typeLicense,
                      decoration: InputDecoration(
                        labelText: _dropDownValue,
                      ),
                    ),
                  )
                ],
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: brand,
                decoration: InputDecoration(
                    labelText: "Marca vehículo",
                    prefixIcon: Icon(Icons.motorcycle_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return brandValidation(value);
                  } else {
                    return 'Ingrese su Marca de su vehiculo';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: model,
                decoration: InputDecoration(
                    labelText: "Modelo vehículo",
                    prefixIcon: Icon(Icons.motorcycle_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return modelValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: numberRegist,
                decoration: InputDecoration(
                    labelText: "Número de registro",
                    prefixIcon: Icon(Icons.motorcycle_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return numberRegistValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: owner,
                decoration: InputDecoration(
                    labelText: "Dueño",
                    prefixIcon: Icon(Icons.person_outline_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return ownerValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
            ])));
  }

  String? nameValidation(String? name) {
    String patttern = r'(^[a-zA-ZÀ-ÿ\u00f1\u00d1]*$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(name!)) {
      return 'Por favor solo ingresa letras';
    }
    return null;
  }

  String? surnameValidation(String? apellido) {
    String patttern = r'(^[a-zA-ZÀ-ÿ\u00f1\u00d1]*$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(apellido!)) {
      return 'Por favor solo ingresa letras';
    }
    return null;
  }

  String? nationalityValidation(String? nacionalidad) {
    String patttern = r'(^[a-zA-ZÀ-ÿ\u00f1\u00d1]*$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(nacionalidad!)) {
      return "Nacionalidad requerida";
    }
    return null;
  }

  String? adressValidation(String? value) {
    if (value!.length == 0) {
      return "Dirección requerida";
    }
    return null;
  }

  String? phoneValidation(String? phone) {
    String patttern = r'(^[0-9]*$)'; //comprobar si funciona
    RegExp regExp = new RegExp(patttern);
    if (phone!.length == 0) {
      return "Telefono Requerido";
    } else if (!regExp.hasMatch(phone)) {
      return "Telefono requiere caracteres numéricos";
    } else if (phone.length != 10) {
      return "Telefono requiere 10 caracteres";
    }
    return null;
  }

  String? ageValidation(String? age) {
    String patttern = r'(^[0-9]*$)'; //comprobar si funciona
    var ageNumber = int.parse(age!);
    print(ageNumber);
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(age)) {
      return "Edad requiere caracteres numéricos";
    } else if (ageNumber < 18) {
      return "Debes ser mayor de edad para registrarte";
    } else if (age.length > 0 && age.length < 3) {
      return null;
    } else {
      return "Edad no valida";
    }
  }

  String? idValidation(String? cedula) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (cedula!.length != 0) {
      if (cedula.length == 10) {
        int provincia = int.parse(cedula[0]) + int.parse(cedula[1]);
        if (provincia < 25 && provincia >= 0) {
          if (int.parse(cedula[2]) < 7 && int.parse(cedula[2]) >= 0) {
            List<int> coeficinetes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
            int suma = 0;
            for (var i = 0; i < coeficinetes.length; i++) {
              int multiplicacion = coeficinetes[i] * int.parse(cedula[i]);
              if (multiplicacion >= 10) {
                multiplicacion = multiplicacion - 9;
              }
              suma += multiplicacion;
            }
            int num_veri = (suma - (suma % 10) + 10) - suma;
            try {
              if (num_veri == int.parse(cedula[9])) {
                return null;
              } else {
                return "Cédula no valida";
              }
            } catch (e) {
              return "Cédula no valida";
            }
          }
        }
      } else {
        return "Cédula requiere 10 caracteres";
      }
    } else if (!regExp.hasMatch(cedula)) {
      return "Cédula requiere caracteres numéricos";
    } else if (cedula.length != 9) {
      return "Cédula requiere 10 caracteres";
    }
  }

  String? emailValidation(String? email) {
    String patttern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(patttern);
    if (email!.length == 0) {
      return "Email es Requerido";
    } else if (!regExp.hasMatch(email)) {
      return "Email necesita un @ y un dominio";
    }
    return null;
  }

  String? passwordValidation(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'Ingrese una contraseña temporal';
    } else if (pass.length < 6) {
      return "La contraseña requiere al menos 6 caracteres";
    }
    return null;
  }

  String? licenseValidation(String? codLicencia) {
    //comprobado
    String patttern = r'(^[0-9]*$)'; //comprobar si funciona
    RegExp regExp = new RegExp(patttern);
    if (codLicencia!.length == 0) {
      return "Licencia Requerida ";
    } else if (!regExp.hasMatch(codLicencia)) {
      return "Licencia requiere caracteres numéricos";
    } else if (codLicencia.length != 8) {
      return "Licencia requiere 8 caracteres";
    }
    return null;
  }

  String? typeLicenseValidation(String? tipoLicencia) {
    if (tipoLicencia!.length == 0) {
      return "Tipo de Licencia requerido";
    } else if (tipoLicencia.length < 1 || tipoLicencia.length > 2) {
      return "Escoja entre A-B, \nSi es Profesional A-B";
    }
    return null;
  }

  String? brandValidation(String? brand) {
    if (brand!.length < 3) {
      return "Mínimo 3 carácteres para la marca";
    }
    return null;
  }

  String? modelValidation(String? modelo) {
    if (modelo!.length < 3) {
      return "Mínimo 3 carácteres para el módelo";
    }
    return null;
  }

  String? numberRegistValidation(String? numRegistro) {
    if (numRegistro!.length == 0) {
      return "Numero de Registro requerido";
    }
    return null;
  }

  String? ownerValidation(String? dueno) {
    String patttern = r'(^[a-zA-ZÀ-ÿ\u00f1\u00d1]*$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(dueno!)) {
      return 'Por favor solo ingresa letras';
    } else if (dueno.length == 0) {
      return "Nombre del Dueño requerido";
    }
    return null;
  }

  Future<void> _sendToServer(bool admin) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference;
      if (admin) {
        reference = FirebaseFirestore.instance.collection("usuario");
        await reference.add({
          "uid": "$us",
          "name": name.text.trim(),
          "surname": surname.text.trim(),
          "Rol": "Motorizado",
          "id": docId.text.trim(),
          "age": age.text.trim(),
          "nationality": nationality.text.trim(),
          "address": address.text.trim(),
          "phone": phone.text.trim(),
          "urlimage": urlImagen,
          "vehicle": {
            "licence": license.text.trim(),
            "type_license": _dropDownValue,
            "brand": brand.text.trim(),
            "model": model.text.trim(),
            "number_register": numberRegist.text.trim(),
            "owner": owner.text.trim()
          }
        });
      } else {
        reference =
            FirebaseFirestore.instance.collection('preregistro_motocycle');
        await reference.add({
          "uid": "$us",
          "name": name.text.trim(),
          "surname": surname.text.trim(),
          "Rol": "Motorizado",
          "id": docId.text.trim(),
          "age": age.text.trim(),
          "nationality": nationality.text.trim(),
          "address": address.text.trim(),
          "phone": phone.text.trim(),
          "email": email.text.trim(),
          "password": password.text.trim(),
          "urlimage": urlImagen,
          "vehicle": {
            "licence": license.text.trim(),
            "type_license": _dropDownValue,
            "brand": brand.text.trim(),
            "model": model.text.trim(),
            "number_register": numberRegist.text.trim(),
            "owner": owner.text.trim()
          },
        });
      }
    });
  }

  Future<void> _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ))
        .user;
    us = user!.uid;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email ?? '';
      });
    } else {
      _success = false;
    }
  }
}
