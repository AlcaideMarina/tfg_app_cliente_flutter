class ImageRoutes {
  static String getRoute(String key) {
    return imageRoutesMap[key] ?? "assets/ic_new_logo.png";
  }

  static final Map<String, String> imageRoutesMap = {
    'ic_logo': 'assets/ic_new_logo.png'
  };
}
