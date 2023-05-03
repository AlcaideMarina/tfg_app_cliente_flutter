

import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;

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


}