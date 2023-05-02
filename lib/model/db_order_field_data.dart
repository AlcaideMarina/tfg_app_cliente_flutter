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
  
}