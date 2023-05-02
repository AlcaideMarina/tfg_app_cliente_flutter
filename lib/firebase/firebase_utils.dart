

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<int> getNewOrderId(String documentId) async{
    QuerySnapshot allOrders = await FirebaseFirestore.instance
        .collection("client_info")
        .doc(documentId)
        .collection("orders")
        .get();
    return allOrders.size;
  }

 // Future<dynamic> saveNewOrder()

}
