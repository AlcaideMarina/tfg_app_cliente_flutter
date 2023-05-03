
import 'package:intl/intl.dart';

enum SingleTableCardPositions {
  leftPosition,
  rightPosition,
  centerPosition
}

enum HomeMenuOptions {
  myProfile,
  billing,
  myOrders,
  newOrder,
  settings
}

final Map<HomeMenuOptions, String> mapHomeMenuOptions = {
  HomeMenuOptions.myProfile: "Mi perfil",
  HomeMenuOptions.billing: "Facturación",
  HomeMenuOptions.myOrders: "Mis pedidos",
  HomeMenuOptions.newOrder: "Nuevo pedido",
  HomeMenuOptions.settings: "Ajustes",
};

final Map<String, int> paymentMethod = {
  "Al contado": 0,
  "Por recibo": 1,
  "Transferencia": 2
};

final Map<String, int> orderStatus = {
  "Pendiente de precio": 0,
  "pedido pendiente": 1,
  "En reparto": 2,
  "Entregado": 3,
  "Intento de entrega": 4,
  "Cancelado": 5
};

String dateFormatPatter = "dd/MM/yyyy";
DateFormat dateFormat = DateFormat(dateFormatPatter);

Map<String, String> monthInSpanish = {
  "01": "Enero",
  "02": "Febrero",
  "03": "Marzo",
  "04": "Abril",
  "05": "Mayo",
  "06": "Junio",
  "07": "Julio",
  "08": "Agosto",
  "09": "Septiembre",
  "10": "Octubre",
  "11": "Noviembre",
  "12": "Diciembre",
};
