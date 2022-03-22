import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

// ignore: must_be_immutable
class Badge extends StatelessWidget {
  Function()? onPressed;
  double? radius;
  Icon? icon;

  Badge({Key? key, this.onPressed, this.radius, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Constants.VINTAGE),
        child: ClipOval(child: icon));
  }
}
