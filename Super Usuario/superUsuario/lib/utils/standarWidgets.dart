import 'package:flutter/material.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class StandarWidget {
  static Widget getBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height * 1.5,
          width: double.infinity,
          decoration: BoxDecoration(color: Constants.WHITE),
        ),
      ],
    );
  }

  static String getFisioImage(String type) {
    return type
        .toLowerCase()
        .replaceAll("á", "a")
        .replaceAll("é", "e")
        .replaceAll("í", "i")
        .replaceAll("ó", "o")
        .replaceAll("ú", "u");
  }

  static AppBar appBar(BuildContext context, String title) {
    return AppBar(title: Text(title));
  }

  static Widget titleToForm(BuildContext context, String title) {
    Color _color = Theme.of(context).selectedRowColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.0),
      child: Text(title,
          style: Theme.of(context).textTheme.headline6!.apply(color: _color)),
    );
  }

  static ButtonStyle buttonStandardStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
        elevation: 5.0,
        shadowColor: Theme.of(context).dividerColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20));
  }

  static Widget labelToButton(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Text(text,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: color)),
    );
  }

  static Widget titleToForm2(BuildContext context, String title) {
    Color _color = Theme.of(context).selectedRowColor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      child: Text(title,
          style: Theme.of(context).textTheme.headline4!.apply(color: _color)),
    );
  }

  static ButtonStyle btnStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
        elevation: 5.0,
        shadowColor: Theme.of(context).dividerColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20));
  }

  static Widget getInfoLine(
      BuildContext context, String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyText2),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.headline6),
    );
  }

  static Widget getStye(BuildContext context, String title, int valor) {
    return TextFormField(
      validator: (value) {
        if (value!.length < valor) {
          return "Debe ingresar un mensaje con al menos $valor caracteres";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.attach_money),
        labelText: title,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 3.0),
        ),
      ),
    );
  }

  static Widget getBoard(BuildContext context, String message, IconData icon) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: Center(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.BORDER_RADIOUS)),
            elevation: Constants.ELEVATION,
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 75),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                icon == Icons.download
                    ? Container(
                        margin: EdgeInsets.all(14.0),
                        height: 35.0,
                        width: 35.0,
                        child: CircularProgressIndicator(),
                      )
                    : Container()
              ],
            )),
      ),
    );
  }
}
