

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;

import '../model/egg_prices_data.dart';

class Utils {

  int paymentMethodStringToInt(String paymentMethodStr) {
    return constants.paymentMethod[paymentMethodStr] ?? -1;
  }

  int orderStatusStringToInt(String status) {
    return constants.orderStatus[status] ?? -1;
  }

  String? orderStatusIntToString(int status) {
    var key = constants.orderStatus.keys.firstWhere(
      (k) => constants.orderStatus[k] == status);
    return key;
  }

  dynamic getKey(Map map, dynamic value) {
    var key = map.keys.firstWhere(
      (k) => map[k] == value);
    return key;
  }

  String getOrderSummary(DBOrderFieldData dbOrderFieldData) {
    List<String> list = [];
    if (dbOrderFieldData.xlDozenQuantity != null && dbOrderFieldData.xlDozenQuantity != 0) {
      list.add("${dbOrderFieldData.xlDozenQuantity} docenas XL");
    }
    if (dbOrderFieldData.xlBoxQuantity != null && dbOrderFieldData.xlBoxQuantity != 0) {
      list.add("${dbOrderFieldData.xlBoxQuantity} cajas XL");
    }
    if (dbOrderFieldData.lDozenQuantity != null && dbOrderFieldData.lDozenQuantity != 0) {
      list.add("${dbOrderFieldData.lDozenQuantity} docenas L");
    }
    if (dbOrderFieldData.lBoxQuantity != null && dbOrderFieldData.lBoxQuantity != 0) {
      list.add("${dbOrderFieldData.lBoxQuantity} cajas L");
    }
    if (dbOrderFieldData.mDozenQuantity != null && dbOrderFieldData.mDozenQuantity != 0) {
      list.add("${dbOrderFieldData.mDozenQuantity} docenas M");
    }
    if (dbOrderFieldData.mBoxQuantity != null && dbOrderFieldData.mBoxQuantity != 0) {
      list.add("${dbOrderFieldData.mBoxQuantity} cajas M");
    }
    if (dbOrderFieldData.sDozenQuantity != null && dbOrderFieldData.sDozenQuantity != 0) {
      list.add("${dbOrderFieldData.sDozenQuantity} docenas S");
    }
    if (dbOrderFieldData.sBoxQuantity != null && dbOrderFieldData.sBoxQuantity != 0) {
      list.add("${dbOrderFieldData.sBoxQuantity} cajas S");
    }

    String summary = "";
    for (String item in list) {
      summary += item;
      if (item != list[list.length - 1]) summary += " - ";
    }
    return summary;
  }

  Timestamp parseStringToTimestamp(String dateStr) {
    return Timestamp.fromDate(DateTime.parse(dateStr));
  }

  DBOrderFieldData getOrderStructure(Map<String, int> productQuantities, EggPricesData eggPrices) {
    int xlBox = 0;
    int xlBoxPrice = 0;
    int xlDozen = 0;
    int xlDozenPrice = 0;
    int lBox = 0;
    int lBoxPrice = 0;
    int lDozen = 0;
    int lDozenPrice = 0;
    int mBox = 0;
    int mBoxPrice = 0;
    int mDozen = 0;
    int mDozenPrice = 0;
    int sBox = 0;
    int sBoxPrice = 0;
    int sDozen = 0;
    int sDozenPrice = 0;

    if (productQuantities.containsKey("xl_box") && productQuantities['xl_box'] != null){
      xlBox = productQuantities['xl_box']!;
    }
    if (productQuantities.containsKey("xl_dozen") && productQuantities['xl_dozen'] != null){
      xlDozen = productQuantities['xl_dozen']!;
    }
    if (productQuantities.containsKey("l_box") && productQuantities['l_box'] != null){
      lBox = productQuantities['l_box']!;
    }
    if (productQuantities.containsKey("l_dozen") && productQuantities['l_dozen'] != null){
      lDozen = productQuantities['l_dozen']!;
    }
    if (productQuantities.containsKey("m_box") && productQuantities['m_box'] != null){
      mBox = productQuantities['m_box']!;
    }
    if (productQuantities.containsKey("m_dozen") && productQuantities['m_dozen'] != null){
      mDozen = productQuantities['m_dozen']!;
    }
    if (productQuantities.containsKey("s_box") && productQuantities['s_box'] != null){
      sBox = productQuantities['s_box']!;
    }
    if (productQuantities.containsKey("s_dozen") && productQuantities['s_dozen'] != null){
      sDozen = productQuantities['s_dozen']!;
    }

    return DBOrderFieldData(
      xlBoxPrice: xlBox == 0 ? null : eggPrices.xlBox!.toDouble(),
      xlBoxQuantity: xlBox,
      xlDozenPrice: xlDozen == 0 ? null : eggPrices.xlDozen!.toDouble(),
      xlDozenQuantity: xlDozen,
      lBoxPrice: lBox == 0 ? null : eggPrices.lBox!.toDouble(),
      lBoxQuantity: lBox,
      lDozenPrice: lDozen == 0 ? null : eggPrices.lDozen!.toDouble(),
      lDozenQuantity: lDozen,
      mBoxPrice: mBox == 0 ? null : eggPrices.mBox!.toDouble(),
      mBoxQuantity: mBox,
      mDozenPrice: mDozen == 0 ? null : eggPrices.mDozen!.toDouble(),
      mDozenQuantity: mDozen,
      sBoxPrice: sBox == 0 ? null : eggPrices.sBox!.toDouble(),
      sBoxQuantity: sBox,
      sDozenPrice: sDozen == 0 ? null : eggPrices.sDozen!.toDouble(),
      sDozenQuantity: sDozen,
    );
  }

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

}