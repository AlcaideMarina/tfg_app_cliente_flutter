import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp approxDatetime;  
  final String createdBy;
  final Timestamp? deliveryDatetime;
  final String? deliveryDni;
  final int? deliveryNote;
  final String? deliveryPerson;
  final String? notes;
  final Map<String, Map<String, num?>> order;
  final Timestamp orderDatetime;
  final int orderId;
  final bool paid;
  final int paymentMethod;
  final int status;
  final double totalPrice;

  OrderModel(
    this.approxDatetime, 
    this.createdBy, 
    this.deliveryDatetime, 
    this.deliveryDni, 
    this.deliveryNote, 
    this.deliveryPerson, 
    this.notes, 
    this.order, 
    this.orderDatetime, 
    this.orderId, 
    this.paid, 
    this.paymentMethod, 
    this.status, 
    this.totalPrice
  );

  factory OrderModel.fromJson(String str) =>
    OrderModel.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
      json['approximate_delivery_datetime'], 
      json['created_by'], 
      json['delivery_datetime'], 
      json['delivery_dni'], 
      json['delivery_note'], 
      json['delivery_person'], 
      json['notes'], 
      json['order'], 
      json['order_datetime'], 
      json['order_id'], 
      json['paid'], 
      json['payment_method'], 
      json['status'], 
      json['total_price']);
  }

  Map<String, dynamic> toMap() => {
      'approximate_delivery_datetime': approxDatetime, 
      'created_by': createdBy, 
      'delivery_datetime': deliveryDatetime, 
      'delivery_dni': deliveryDni, 
      'delivery_note': deliveryNote, 
      'delivery_person': deliveryNote, 
      'notes': notes, 
      'order': order, 
      'order_datetime': orderDatetime, 
      'order_id': orderId, 
      'paid': paid, 
      'payment_method': paymentMethod, 
      'status': status, 
      'total_price': totalPrice
  };
  
}