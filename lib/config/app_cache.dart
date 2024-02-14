import 'dart:convert';
import '../core/classes/cache_manager.dart';

class AppCache {
  Map<String, String>? udata;

  void doLogin(String username, String password) {
    udata = {'user': username, 'pass': password};
    // TODO: Authenticate method.
    // if (username == '0366921567') {
    Cache.saveData('auth_data', jsonEncode(udata));
    // }
  }

  Future<Map<String, String>> auth() async {
    var data = await Cache.readData('auth_data');
    return udata = jsonDecode(data);
  }

  Future<bool> isLogin() async {
    var data = await Cache.readData('auth_data');
    if (data != null) {
      return true;
    }
    return false;
  }

  void doLogout() {
    Cache.deleteData('auth_data');
  }

  Future<bool> isLogout() async {
    var data = await Cache.readData('auth_data');
    if (data == null) {
      return true;
    }
    return false;
  }
}
