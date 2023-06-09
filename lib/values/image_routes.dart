class ImageRoutes {

  static const String folder = 'assets/';
  static const String fileType = '.png';

  static String getRoute(String key) {
    return imageRoutesMap[key] ?? "assets/ic_new_logo.png";
  }

  static final Map<String, String> imageRoutesMap = {
    'ic_logo': 'assets/ic_new_logo.png',
    'ic_logout': 'assets/ic_logout.png',
    'ic_add': 'assets/ic_add.png',
    'ic_economy': 'assets/ic_economy.png',
    'ic_orders': 'assets/ic_orders.png',
    'ic_settings': 'assets/ic_settings.png',
    'ic_users': 'assets/ic_users.png',
    'ic_next_arrow': '${folder}ic_next_arrow$fileType',
  };
}
