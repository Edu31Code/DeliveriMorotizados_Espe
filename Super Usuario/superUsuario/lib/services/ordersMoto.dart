import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prowess_app/models/MotorizedOrders/MotorizedOrdersModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class OrdersMoto {
  OrdersMoto();

  Future<List<MotorizedOrders>> getPackages(String document) async {
    List<MotorizedOrders> items = [];
    try {
      Map<String, dynamic> user = (await FirebaseFirestore.instance
              .collection("pedidos")
              .doc(document)
              .get())
          .data() as Map<String, dynamic>;
      items.add(MotorizedOrders.fromJson(user));
      //}
      return items;
    } catch (e) {
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print("Exception $e");
      return items;
    }
  }

  updatePackages(String document, MotorizedOrders package) async {}

  /*"NlEfqeisb9YmwUYljV1H"*/
  /*  String getUID() {

    String uid = "";
    var snapshot = (FirebaseAuth.instance.currentUser()).uid;
        snapshot.first.toString();
        
    return  uid;
  }*/

}
