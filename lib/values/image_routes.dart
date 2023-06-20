class ImageRoutes {
  static String getRoute(String key) {
    return imageRoutesMap[key] ?? "assets/ic_new_logo.png";
  }

  static final Map<String, String> imageRoutesMap = {
    'ic_logo': 'assets/ic_new_logo.png',
    'ic_logout': 'assets/ic_logout.png',
    'ic_add': 'assets/ic_add.png',
    'ic_economy': 'assets/ic_ecconomy.png',
    'ic_orders': 'assets/ic_orders.png',
    'ic_settings': 'assets/ic_settings.png',
    'ic_users': 'assets/ic_users.png',
  };
}
