import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class ItemsMenu extends StatefulWidget {
  ItemsMenu({Key? key, required this.title, required this.method})
      : super(key: key);
  final String title;
  final Widget method;

  @override
  _ItemsMenuState createState() => _ItemsMenuState();
}

class _ItemsMenuState extends State<ItemsMenu> {
  _ItemsMenuState();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.method),
            );
          },
          child: Container(
            margin: EdgeInsets.all(2),
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Constants.VINTAGE,
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.title,
                    style: TextStyle(
                        letterSpacing: 6,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
