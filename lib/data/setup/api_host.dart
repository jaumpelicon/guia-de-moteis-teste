import 'package:flutter/foundation.dart';

class ApiHost {
  ApiHost._();

  static String get baseApiPath {
    if (kDebugMode) return 'www.jsonkeeper.com/b';
    return 'www.jsonkeeper.com/b';
  }

  static String get baseURL => 'https://$baseApiPath/';
}
