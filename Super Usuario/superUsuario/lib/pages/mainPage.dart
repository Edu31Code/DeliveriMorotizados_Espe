import 'package:flutter/material.dart';
import 'package:prowess_app/components/navbarComponent.dart';
import 'package:prowess_app/models/motocycleModel.dart';
import 'package:prowess_app/pages/orderPage.dart';
import 'package:prowess_app/pages/settingsPage.dart';
import 'package:prowess_app/utils/itemMenu.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.titulo, required this.motocycle})
      : super(key: key);
  final String titulo;
  final Motocycle motocycle;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: getbody(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
        ]),
        child: ClipRRect(
          child: NavbarComponent(
            index: this._selectedIndex,
            onTap: (value) {
              _onItemTapped(value);
            },
            items: menuOptions
                .map((e) =>
                    BottomNavigationBarItem(icon: e.icon, label: e.label))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getbody(int index) {
    if (index == 0) {
      return OrderPage(
        motocycle: widget.motocycle,
      );
    } else if (index == 1) {
      return SettingsPage(motocycle: widget.motocycle);
    }
    return Text("error");
  }
}
