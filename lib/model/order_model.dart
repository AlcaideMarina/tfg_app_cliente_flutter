import 'dart:convert';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp approxDatetime;
  final int clientId;
  final String company;
  final String createdBy;
  final Timestamp? deliveryDatetime;
  final String? deliveryDni;
  final int? deliveryNote;
  final String? deliveryPerson;
  final String? lot;
  final String? notes;
  final Map<String, Map<String, num?>> order;
  final Timestamp orderDatetime;
  final int orderId;
  final bool paid;
  final int paymentMethod;
  final int status;
  final double? totalPrice;
  String? documentId;

  OrderModel(
    this.approxDatetime,  
    this.clientId,
    this.company, 
    this.createdBy, 
    this.deliveryDatetime, 
    this.deliveryDni, 
    this.deliveryNote, 
    this.deliveryPerson, 
    this.lot,
    this.notes, 
    this.order, 
    this.orderDatetime, 
    this.orderId, 
    this.paid, 
    this.paymentMethod, 
    this.status, 
    this.totalPrice,
    {this.documentId}
  );

  factory OrderModel.fromJson(String str) =>
    OrderModel.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json) {

    Map<String, Map<String, num?>> orderMap = {};
    (json['order'] as Map<String, dynamic>).forEach(
      (k1, v1) {
        orderMap[k1] = {};
        try {
          Map<String, num?> orderMapAux = {};
          (v1 as Map<String, dynamic>).forEach(
            (k2, v2) {
              orderMapAux[k2] = v2; 
            }
          );
          orderMap[k1] = orderMapAux;
        } catch (e) {
          orderMap[k1] = {"price": null, "quantity": 0};
          developer.log(
              'Error - OrderModel - OrderModel.fromMap() - order: $e');
        }
      },
    );
    return OrderModel(
      json['approximate_delivery_datetime'], 
      json['client_id'],
      json['company'],
      json['created_by'], 
      json['delivery_datetime'], 
      json['delivery_dni'], 
      json['delivery_note'], 
      json['delivery_person'], 
      json['lot'],
      json['notes'], 
      orderMap, 
      json['order_datetime'], 
      json['order_id'], 
      json['paid'], 
      json['payment_method'], 
      json['status'], 
      json['total_price'],);
  }

  Map<String, dynamic> toMap() => {
      'approximate_delivery_datetime': approxDatetime, 
      'client_id': clientId,
      'company': company,
      'created_by': createdBy, 
      'delivery_datetime': deliveryDatetime, 
      'delivery_dni': deliveryDni, 
      'delivery_note': deliveryNote, 
      'delivery_person': deliveryNote, 
      'lot': lot,
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