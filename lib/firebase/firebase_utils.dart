import 'package:cloud_firestore/cloud_firestore.dart';

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders(String documentId) {
    return FirebaseFirestore.instance
        .collection('client_info')
        .doc(documentId)
        .collection("orders")
        .orderBy("order_datetime", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEggPrices() async {
    return FirebaseFirestore.instance
        .collection('default_constants')
        .where('constant_name', isEqualTo: 'egg_prices')
        .get();
  }

}
