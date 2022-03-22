import 'package:flutter/material.dart';
import 'package:prowess_app/utils/enums.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class RolMotocycleMainPaige extends StatefulWidget {
  RolMotocycleMainPaige({Key? key, required this.titulo}) : super(key: key);
  final String titulo;

  @override
  _RolMotocycleMainPaigeState createState() => _RolMotocycleMainPaigeState();
}

class _RolMotocycleMainPaigeState extends State<RolMotocycleMainPaige> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: (_selectedIndex != contentWidget.length - 1),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: contentWidget[_selectedIndex]),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS),
          child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (value) {
                _onItemTapped(value);
              },
              unselectedItemColor: Colors.grey,
              selectedItemColor: Constants.TEXT_COLOR,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: menuOptions
                  .map((e) =>
                      BottomNavigationBarItem(icon: e.icon, label: e.label))
                  .toList()),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
