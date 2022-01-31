import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivity {
  static Future<bool> hasConection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
