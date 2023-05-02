

import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;

class Utils {

  int paymentMethodStringToInt(String paymentMethodStr) {
    return constants.paymentMethod[paymentMethodStr] ?? -1;
  }

  int orderStatusStringToInt(String status) {
    return constants.orderStatus[status] ?? -1;
  }


}