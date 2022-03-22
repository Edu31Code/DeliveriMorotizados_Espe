import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

// ignore: must_be_immutable
class NavbarComponent extends StatelessWidget {
  int index;
  List<BottomNavigationBarItem> items;
  Function(int)? onTap;

  NavbarComponent({Key? key, required this.index, required this.items, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: this.index,
        onTap: this.onTap,
        unselectedItemColor: Constants.TEXT_COLOR,
        selectedItemColor: Constants.TEXT_COLOR,
        showUnselectedLabels: false,
        items: this.items);
  }
}
