// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/pages/settingsPage.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

import 'AdminPage.dart';

class UpdateMororizado extends StatefulWidget {
  const UpdateMororizado({Key? key, required this.motocycle, required this.adm})
      : super(key: key);

  final Motocycle motocycle;
  final bool adm;
  @override
  _UpdateMororizadoState createState() => _UpdateMororizadoState();
}

class _UpdateMororizadoState extends State<UpdateMororizado> {
  late String _dropDownValue = "";
  late String _value = widget.motocycle.vehicle!.typeLicense!;
  int currentStep = 0;

  late String us = "";
  // ignore: unused_field
  late bool? _success;
  // ignore: unused_field
  late String _userEmail = '';

  late var name = TextEditingController(text: widget.motocycle.name);
  late var surname = TextEditingController(text: widget.motocycle.surname);
  late var nationality =
      TextEditingController(text: widget.motocycle.nationality);
  late var address = TextEditingController(text: widget.motocycle.address);
  late var phone = TextEditingController(text: widget.motocycle.phone);

  late var age = TextEditingController(text: widget.motocycle.age);
  late var docId = TextEditingController(text: widget.motocycle.id);
  final email = TextEditingController();
  final password = TextEditingController();

  late var license =
      TextEditingController(text: widget.motocycle.vehicle!.licence);
  late var typeLicense = TextEditingController();
  late var brand = TextEditingController(text: widget.motocycle.vehicle!.brand);
  late var model = TextEditingController(text: widget.motocycle.vehicle!.model);
  late var numberRegist =
      TextEditingController(text: widget.motocycle.vehicle!.numberRegister);
  late var owner = TextEditingController(text: widget.motocycle.vehicle!.owner);

  List<GlobalKey<FormState>> _listKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

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

  // ignore: unused_element
  void _validation(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                'Esta seguro de continuar ya que no se actualizaran tus datos?'),
            actions: <Widget>[
              OutlineButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              OutlineButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        });
    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _validation(context);
        return Future.value(false);
      },
      child: SizedBox(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Actualizar Motorizado"),
            automaticallyImplyLeading: false,
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white70)),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white70)),
                        onPressed: details.onStepContinue,
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                );
              },
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () async {
                final isLastStep = currentStep == getSteps().length - 1;
                if (_listKeys[currentStep].currentState!.validate()) {
                  if (isLastStep) {
                    await _sendToServer();
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Actualizacion Completada',
                              textAlign: TextAlign.center,
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Image.asset(
                                    "assets/images/update.gif",
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
                                    if (!widget.adm) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute<Null>(
                                              builder: (BuildContext contex) {
                                        return new SettingsPage(
                                            motocycle: widget.motocycle);
                                      }), (Route<dynamic> route) => false);
                                    } else {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute<Null>(
                                              builder: (BuildContext contex) {
                                        return new AdminPage();
                                      }), (Route<dynamic> route) => false);
                                    }
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
                      Navigator.of(context).pop();
                    }
                  : () {
                      setState(() => currentStep -= 1);
                    },
            ),
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
                  controller: name,
                  decoration: InputDecoration(
                      labelText: "Nombre",
                      prefixIcon: Icon(Icons.person_outline_outlined)),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return nameValidation(value);
                    } else {
                      return 'No puede dejar esta casillero vacio';
                    }
                  }),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  }),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  }),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: address,
                decoration: InputDecoration(
                    labelText: "Direccion",
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
                      labelText: "Telefono", prefixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return phoneValidation(value);
                    } else {
                      return 'No puede dejar esta casillero vacio';
                    }
                  }),
            ])));
  }

  Widget formUser2() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
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
                    return adressValidation(value);
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
                    labelText: "Cedula",
                    prefixIcon: Icon(Icons.person_outline_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return idValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
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
                    labelText: "Numero de Licencia",
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
                          ? Text('$_value')
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
                    labelText: "Marca",
                    prefixIcon: Icon(Icons.motorcycle_outlined)),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return brandValidation(value);
                  } else {
                    return 'No puede dejar esta casillero vacio';
                  }
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: model,
                decoration: InputDecoration(
                    labelText: "Modelo",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Numero de Registro",
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
    if (nacionalidad!.length == 0) {
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
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(age!)) {
      return "Edad requiere caracteres numéricos";
    } else if (age.length > 0 && age.length <= 3) {
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
      return 'Ingrese una contraseña';
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
      return "Escoja entre A-B-F si No Profesional, \nSi es Profesional A1-C-C1-D-D1-E-E1-G";
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
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(dueno!)) {
      return 'Por favor solo ingresa letras';
    } else if (dueno.length == 0) {
      return "Nombre del Dueño requerido";
    }
    return null;
  }

  Future<void> _sendToServer() async {
    widget.motocycle.address = address.text;
    widget.motocycle.age = age.text;
    widget.motocycle.id = docId.text;
    widget.motocycle.name = name.text;
    widget.motocycle.nationality = nationality.text;
    widget.motocycle.phone = phone.text;
    widget.motocycle.surname = surname.text;
    widget.motocycle.vehicle!.brand = brand.text;
    widget.motocycle.vehicle!.licence = license.text;
    widget.motocycle.vehicle!.model = model.text;
    widget.motocycle.vehicle!.numberRegister = numberRegist.text;
    widget.motocycle.vehicle!.owner = owner.text;
    widget.motocycle.vehicle!.typeLicense = _dropDownValue;

    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("usuario");
      QuerySnapshot pd = await reference.get();
      String docUid = "";
      for (var doc in pd.docs) {
        if (widget.motocycle.uid == doc.get("uid").toString()) {
          docUid = doc.id;
          break;
        }
      }
      await reference.doc(docUid).update(widget.motocycle.toJson());
    });
  }
}
