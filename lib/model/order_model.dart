import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp approxDeliveryDatetime;
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
  final int? orderId;
  final bool paid;
  final int paymentMethod;
  final int status;
  final double? totalPrice;
  final String? documentId;

  OrderModel(
      this.approxDeliveryDatetime,
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
      this.documentId);

  factory OrderModel.fromJson(String str, String? docId) =>
      OrderModel.fromMap(jsonDecode(str), docId);

  String toJson() => jsonEncode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json, String? docId) {
    Map<String, Map<String, num>> orderMap = {};
    (json['order'] as Map<String, dynamic>).forEach((key, value) {
      Map<String, num> aux = {};
      (value as Map<String, dynamic>).forEach((key2, value2) {
        aux.addAll({key2: value2});
      });

      orderMap.addAll({key: aux});
    });

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
        json['total_price'],
        docId);
  }

  Map<String, dynamic> toMap() => {
        'approximate_delivery_datetime': approxDeliveryDatetime,
        'client_id': clientId,
        'company': company,
        'created_by': createdBy,
        'delivery_datetime': deliveryDatetime,
        'delivery_dni': deliveryDni,
        'delivery_note': deliveryNote,
        'delivery_person': deliveryPerson,
        'lot': lot,
        'notes': notes,
        'order': order,
        'order_datetime': orderDatetime,
        'order_id': orderId,
        'paid': paid,
        'payment_method': paymentMethod,
        'status': status,
        'total_price': totalPrice,
      };
}
