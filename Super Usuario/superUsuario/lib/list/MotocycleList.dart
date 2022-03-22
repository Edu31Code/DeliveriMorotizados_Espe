import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prowess_app/card/MotocycleListCard.dart';
import 'package:prowess_app/utils/constants.dart' as Constants;

class MotocycleList extends StatefulWidget {
  const MotocycleList({Key? key, required this.admin}) : super(key: key);
  final bool admin;
  @override
  _MotocycleListState createState() => _MotocycleListState();
}

class _MotocycleListState extends State<MotocycleList> {
  final textController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> motocycle;
    if (widget.admin) {
      motocycle = FirebaseFirestore.instance
          .collection("usuario")
          .where("Rol", isEqualTo: "Motorizado")
          .snapshots();
    } else {
      motocycle = FirebaseFirestore.instance
          .collection('preregistro_motocycle')
          .snapshots();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.WHITE,
          title: Text(
            (widget.admin)
                ? "Motorizados Registrados"
                : "Control de Aspirantes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView(
          children: [
            MotocycleCard(
              currentMotocycle: motocycle,
              adm: widget.admin,
            )
            //DeleteBikeCard(currentMotocycle: motocycle),
          ],
        ));
  }
}
