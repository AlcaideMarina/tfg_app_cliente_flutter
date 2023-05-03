import 'package:cloud_firestore/cloud_firestore.dart';

class OrderBillingModel {
  final int orderId;
  final Timestamp orderDatetime;
  final int paymentMethod;
  final double? totalPrice;
  final bool paid;

  OrderBillingModel(
    this.orderId, 
    this.orderDatetime, 
    this.paymentMethod, 
    this.totalPrice, 
    this.paid
  );

}
