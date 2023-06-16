
class DBOrderFieldData{
  double? xlBoxPrice;
  int? xlBoxQuantity;
  double? xlDozenPrice;
  int? xlDozenQuantity;
  double? lBoxPrice;
  int? lBoxQuantity;
  double? lDozenPrice;
  int? lDozenQuantity;
  double? mBoxPrice;
  int? mBoxQuantity;
  double? mDozenPrice;
  int? mDozenQuantity;
  double? sBoxPrice;
  int? sBoxQuantity;
  double? sDozenPrice;
  int? sDozenQuantity;

  DBOrderFieldData({
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
    }
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
      if (aux.containsKey("quantity")) xlBoxQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) xlBoxPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("xl_dozen")) {
      Map<String, dynamic> aux = json["xl_dozen"]!;
      if (aux.containsKey("quantity")) xlDozenQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) xlDozenPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("l_box")) {
      Map<String, dynamic> aux = json["l_box"]!;
      if (aux.containsKey("quantity")) lBoxQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) lBoxPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("l_dozen")) {
      Map<String, dynamic> aux = json["l_dozen"]!;
      if (aux.containsKey("quantity")) lDozenQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) lDozenPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("m_box")) {
      Map<String, dynamic> aux = json["m_box"]!;
      if (aux.containsKey("quantity")) mBoxQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) mBoxPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("m_dozen")) {
      Map<String, dynamic> aux = json["m_dozen"]!;
      if (aux.containsKey("quantity")) mDozenQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) mDozenPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("s_box")) {
      Map<String, dynamic> aux = json["s_box"]!;
      if (aux.containsKey("quantity")) sBoxQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) sBoxPriceMap = aux["price"].toDouble();
    }
    if (json.containsKey("s_dozen")) {
      Map<String, dynamic> aux = json["s_dozen"]!;
      if (aux.containsKey("quantity")) sDozenQuantityMap = aux["quantity"].toInt();
      if (aux.containsKey("price")) sDozenPriceMap = aux["price"].toDouble();
    }

    return DBOrderFieldData(
      xlBoxPrice: xlBoxPriceMap,
      xlBoxQuantity: xlBoxQuantityMap,
      xlDozenPrice: xlDozenPriceMap,
      xlDozenQuantity: xlDozenQuantityMap,
      lBoxPrice: lBoxPriceMap,
      lBoxQuantity: lBoxQuantityMap,
      lDozenPrice: lDozenPriceMap,
      lDozenQuantity: lDozenQuantityMap,
      mBoxPrice: mBoxPriceMap,
      mBoxQuantity: mBoxQuantityMap,
      mDozenPrice: mDozenPriceMap,
      mDozenQuantity: mDozenQuantityMap,
      sBoxPrice: sBoxPriceMap,
      sBoxQuantity: sBoxQuantityMap,
      sDozenPrice: sDozenPriceMap,
      sDozenQuantity: sDozenQuantityMap,
    );
  }
  
}