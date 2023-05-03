import 'dart:convert';

class DBOrderFieldData{
  final double? xlBoxPrice;
  final int? xlBoxQuantity;
  final double? xlDozenPrice;
  final int? xlDozenQuantity;
  final double? lBoxPrice;
  final int? lBoxQuantity;
  final double? lDozenPrice;
  final int? lDozenQuantity;
  final double? mBoxPrice;
  final int? mBoxQuantity;
  final double? mDozenPrice;
  final int? mDozenQuantity;
  final double? sBoxPrice;
  final int? sBoxQuantity;
  final double? sDozenPrice;
  final int? sDozenQuantity;

  DBOrderFieldData(
    this.xlBoxPrice, 
    this.xlBoxQuantity, 
    this.xlDozenPrice, 
    this.xlDozenQuantity, 
    this.lBoxPrice, 
    this.lBoxQuantity, 
    this.lDozenPrice, 
    this.lDozenQuantity, 
    this.mBoxPrice, 
    this.mBoxQuantity, 
    this.mDozenPrice, 
    this.mDozenQuantity, 
    this.sBoxPrice, 
    this.sBoxQuantity, 
    this.sDozenPrice, 
    this.sDozenQuantity
  );

  Map<String, Map<String, num?>> toMap() {
    
    Map<String, Map<String, num?>> map = {};

    if (xlDozenQuantity != null && xlDozenQuantity != 0) {
      map['xl_dozen'] = {'price': xlDozenPrice, 'quantity': xlDozenQuantity};
    }
    if (xlBoxQuantity != null && xlBoxQuantity != 0) {
      map['xl_box'] = {'price': xlBoxPrice, 'quantity': xlBoxQuantity};
    }
    if (lDozenQuantity != null && lDozenQuantity != 0) {
      map['l_dozen'] = {'price': lDozenPrice, 'quantity': lDozenQuantity};
    }
    if (lBoxQuantity != null && lBoxQuantity != 0) {
      map['l_box'] = {'price': lBoxPrice, 'quantity': lBoxQuantity};
    }
    if (mDozenQuantity != null && mDozenQuantity != 0) {
      map['m_dozen'] = {'price': mDozenPrice, 'quantity': mDozenQuantity};
    }
    if (mBoxQuantity != null && mBoxQuantity != 0) {
      map['m_box'] = {'price': mBoxPrice, 'quantity': mBoxQuantity};
    }
    if (sDozenQuantity != null && sDozenQuantity != 0) {
      map['s_dozen'] = {'price': sDozenPrice, 'quantity': sDozenQuantity};
    }
    if (sBoxQuantity != null && sBoxQuantity != 0) {
      map['s_box'] = {'price': sBoxPrice, 'quantity': sBoxQuantity};
    }

    return map;
  }

  factory DBOrderFieldData.fromMap(Map<String, Map<String, num?>> json) {

    int? xlBoxQuantityMap;
    double? xlBoxPriceMap;
    int? xlDozenQuantityMap;
    double? xlDozenPriceMap;
    int? lBoxQuantityMap;
    double? lBoxPriceMap;
    int? lDozenQuantityMap;
    double? lDozenPriceMap;
    int? mBoxQuantityMap;
    double? mBoxPriceMap;
    int? mDozenQuantityMap;
    double? mDozenPriceMap;
    int? sBoxQuantityMap;
    double? sBoxPriceMap;
    int? sDozenQuantityMap;
    double? sDozenPriceMap;

    if (json.containsKey("xl_box")) {
      Map<String, dynamic> aux = json["xl_box"]!;
      if (aux.containsKey("quantity")) xlBoxQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) xlBoxPriceMap = aux["price"];
    }
    if (json.containsKey("xl_dozen")) {
      Map<String, dynamic> aux = json["xl_dozen"]!;
      if (aux.containsKey("quantity")) xlDozenQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) xlDozenPriceMap = aux["price"];
    }
    if (json.containsKey("l_box")) {
      Map<String, dynamic> aux = json["l_box"]!;
      if (aux.containsKey("quantity")) lBoxQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) lBoxPriceMap = aux["price"];
    }
    if (json.containsKey("l_dozen")) {
      Map<String, dynamic> aux = json["l_dozen"]!;
      if (aux.containsKey("quantity")) lDozenQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) lDozenPriceMap = aux["price"];
    }
    if (json.containsKey("m_box")) {
      Map<String, dynamic> aux = json["m_box"]!;
      if (aux.containsKey("quantity")) mBoxQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) mBoxPriceMap = aux["price"];
    }
    if (json.containsKey("m_dozen")) {
      Map<String, dynamic> aux = json["m_dozen"]!;
      if (aux.containsKey("quantity")) mDozenQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) mDozenPriceMap = aux["price"];
    }
    if (json.containsKey("s_box")) {
      Map<String, dynamic> aux = json["s_box"]!;
      if (aux.containsKey("quantity")) sBoxQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) sBoxPriceMap = aux["price"];
    }
    if (json.containsKey("s_dozen")) {
      Map<String, dynamic> aux = json["s_dozen"]!;
      if (aux.containsKey("quantity")) sDozenQuantityMap = aux["quantity"];
      if (aux.containsKey("price")) sDozenPriceMap = aux["price"];
    }

    return DBOrderFieldData(
      xlBoxPriceMap,
      xlBoxQuantityMap,
      xlDozenPriceMap,
      xlDozenQuantityMap,
      lBoxPriceMap,
      lBoxQuantityMap,
      lDozenPriceMap,
      lDozenQuantityMap,
      mBoxPriceMap,
      mBoxQuantityMap,
      mDozenPriceMap,
      mDozenQuantityMap,
      sBoxPriceMap,
      sBoxQuantityMap,
      sDozenPriceMap,
      sDozenQuantityMap,
    );
  }
  
}