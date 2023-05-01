
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
  HomeMenuOptions.settings: "Ajutes",
};
