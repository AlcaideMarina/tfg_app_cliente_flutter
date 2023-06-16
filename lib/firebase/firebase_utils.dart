import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/order_model.dart';

class FirebaseUtils {

  static FirebaseUtils? _instance;
  FirebaseUtils._() : super();

  static FirebaseUtils get instance {
    return _instance ??= FirebaseUtils._();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserFromUid(String uid) async {
    return await FirebaseFirestore.instance
        .collection('client_info')
        .where('uid', isEqualTo: uid)
        .get();
  }

  Future<int> getNewOrderId(String documentId) async {
    QuerySnapshot allOrders = await FirebaseFirestore.instance
        .collection("client_info")
        .doc(documentId)
        .collection("orders")
        .get();
    return allOrders.size;
  }

  Future<bool> saveNewOrder(String documentId, OrderModel orderModel) async {
    return await FirebaseFirestore.instance
        .collection("client_info")
        .doc(documentId)
        .collection("orders")
        .add(orderModel.toMap())
        .then((value) {
          var a = value;
          return true;
        })
        .catchError((error) => false);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEggPrices() async {
    return FirebaseFirestore.instance
        .collection('default_constants')
        .where('constant_name', isEqualTo: 'egg_prices')
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders(String documentId) {
    return FirebaseFirestore.instance
        .collection('client_info')
        .doc(documentId)
        .collection("orders")
        .orderBy("order_datetime", descending: true)
        .snapshots();
  }

  Future<bool?> changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);
    
    bool conf = false;
    await user
      .reauthenticateWithCredential(cred)
      .then((value) async {
        await user.updatePassword(newPassword).then((_) {
          conf = true;
        }).catchError((error) {
          conf = false;
        });
      }).catchError((err) {
        conf = false;
      });
    return conf;
  }

}
