import 'package:flutter/material.dart';
import 'package:prowess_app/components/buttonComponent.dart';
import 'package:prowess_app/components/modalComponent.dart';
import 'package:prowess_app/components/badgeComponent.dart';
import 'package:prowess_app/components/textInputComponent.dart';
import 'package:prowess_app/components/titleComponent.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  Function()? onSubmit;

  ForgetPassword({Key? key, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalCard(
      onClose: () {
        closeAction(context);
      },
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Badge(
                icon: Icon(Icons.lock, color: Constants.WHITE, size: 50),
                radius: 75),
            Container(
              width: 325.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TitleComponent(title: 'Nueva Contraseña'),
            ),
            TextInputComponent(
                passwordType: true,
                icon: Icon(Icons.lock_outline,
                    color: Theme.of(context).primaryColorDark),
                labelText: 'Contraseña'),
            TextInputComponent(
                passwordType: true,
                icon: Icon(Icons.lock_outline,
                    color: Theme.of(context).primaryColorDark),
                labelText: 'Confirmar Contraseña'),
            SizedBox(height: 35.0),
            Container(
                child: ButtonComponent(
              onPressed: this.onSubmit,
              width: MediaQuery.of(context).size.width,
              text: "Cambiar Contraseña",
            ))
          ]),
        )
      ],
    );
  }
}

closeAction(BuildContext context) {
  Navigator.of(context).pop();
}

// ignore: must_be_immutable


