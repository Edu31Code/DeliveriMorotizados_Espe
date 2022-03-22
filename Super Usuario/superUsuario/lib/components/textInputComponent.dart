import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

// ignore: must_be_immutable
class TextInputComponent extends StatelessWidget {
  String? hintText;
  String? labelText;
  bool passwordType;
  Icon? icon;

  TextInputComponent(
      {Key? key, this.hintText, this.labelText, this.icon, this.passwordType = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS)),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            elevation: Constants.ELEVATION,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: TextField(
                    obscureText: this.passwordType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: this.icon,
                      hintText: this.hintText,
                      labelText: this.labelText,
                      errorText: snapshot.error?.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
