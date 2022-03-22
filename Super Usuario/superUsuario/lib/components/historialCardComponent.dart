import 'package:flutter/material.dart';

import 'package:prowess_app/utils/constants.dart' as Constants;

// ignore: must_be_immutable
class HistorialCardComponent extends StatelessWidget {
  Color? color;
  Widget? child;
  Function()? onTap;

  HistorialCardComponent({Key? key, this.color = Colors.white, this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (this.onTap == null) ? () {} : this.onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        child: Card(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS)),
          color: Color.fromRGBO(224, 224, 224, 1),
          shadowColor: Colors.green.shade100,
          borderOnForeground: false,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          elevation: Constants.ELEVATION,
          child: this.child,
        ),
      ),
    );
  }
}


