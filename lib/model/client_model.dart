import 'dart:convert';
import 'dart:developer' as developer;

class ClientModel {
  final String cif;
  final String city;
  final String company;
  final String createdBy;
  final bool deleted;
  final String direction;
  final String email;
  final bool hasAccount;
  final String id;
  final List<Map<String, int>> phone;
  final int postalCode;
  final String province;
  final String uid;
  final String user;
  final String doocumentId;

  ClientModel(
    this.cif, 
    this.city, 
    this.company, 
    this.createdBy, 
    this.deleted, 
    this.direction, 
    this.email, 
    this.hasAccount, 
    this.id,
    this.phone, 
    this.postalCode, 
    this.province, 
    this.uid, 
    this.user, 
    this.doocumentId
  );

  factory ClientModel.fromJson(String str) =>
      ClientModel.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

  factory ClientModel.fromMap(Map<String, dynamic> json) {
    List<Map<String, int>> phoneMap = [];
    (json['phone'] as List<dynamic>).forEach((element) {
      try {
        (element as Map<String, dynamic>).forEach((key, value) {
          phoneMap.add({key: element[key]});
        });
      } catch (e) {
        phoneMap.add({'no-info': 0});
        developer.log('Error - ClientModel - ClientModel.fromMap() - phones: $e');
      }
    });

    // TODO: Investigar - ¿Deberíamos meter documentId?
    return ClientModel(
        json['cif'],
        json['city'],
        json['company'],
        json['created_by'],
        json['deleted'],
        json['direction'],
        json['email'],
        json['has_account'],
        json['id'],
        phoneMap,
        json['postal_code'],
        json['province'],
        json['uid'],
        json['user'],
        json['document_id']);
  }

  Map<String, dynamic> toMap() => {
        // TODO: ¿deberíamos añadir documentId? Entiendo que no porque no se guarda en bbdd como tal
        'cif': cif,
        'city': city,
        'created_by': createdBy,
        'company': company,
        'deleted': deleted,
        'direction': direction,
        'email': email,
        'has_account': hasAccount,
        'id': id,
        'phone': phone,
        'postal_code': postalCode,
        'province': province,
        'uid': uid,
        'user': user,
      };
}
