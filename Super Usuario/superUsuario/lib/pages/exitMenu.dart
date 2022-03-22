import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;
import 'package:prowess_app/pages/loginPages.dart';

class ExitMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Text("Prowess"),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Constants.VINTAGE,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined,
                color: Theme.of(context).primaryColorDark),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
