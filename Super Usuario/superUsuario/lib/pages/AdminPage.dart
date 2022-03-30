import 'package:flutter/material.dart';
import 'package:prowess_app/pages/RegisterPageAdm.dart';
import 'package:prowess_app/pages/RegisterPageMotocycle.dart';
import 'package:prowess_app/pages/exitMenu.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'package:prowess_app/list/MotocycleList.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ExitMenu(),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Constants.WHITE,
          title: Text("Menú Administrador/a",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Constants.VINTAGE),
                  child: ClipOval(
                      child:
                          Icon(Icons.person, color: Constants.WHITE, size: 50)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Text("Bienvenid@",
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                                  adm: true,
                                )));
                  },
                  child: Text("Registrar Motorizados",
                      style: TextStyle(color: Constants.WHITE)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                            builder: (context) => MotocycleList(
                                  admin: true,
                                )));
                  },
                  child: Text(
                    "Ver Motorizados",
                    style: TextStyle(color: Constants.WHITE),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                            builder: (context) => MotocycleList(
                                  admin: false,
                                )));
                  },
                  child: Text(
                    "Revisar solicitudes",
                    style: TextStyle(color: Constants.WHITE),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                            builder: (context) => RegisterPageAdm()));
                  },
                  child: Text(
                    "Registrar Administrador",
                    style: TextStyle(color: Constants.WHITE),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
}


