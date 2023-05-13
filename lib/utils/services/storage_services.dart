import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GetxService is also used to  serves to control events on each of its pages like GetxController
// But GetxService is not automatically disposed (nor can be removed with Get.delete())

// So it is used for situations like "once started, that """service will remain in memory""", such as Auth control "
// Only way to remove it is Get.reset().

// we can use "to" to access the methods and variables inside of the class
class StorageServices extends GetxService {
  // important
  static StorageServices get to => Get.find();

  late final SharedPreferences _pref;

  Future<StorageServices> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  // Removes an entry
  Future<bool> remove(String key) async {
    return await _pref.remove(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _pref.setStringList(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? '';
  }

  bool getBool(String key) {
    return _pref.getBool(key) ?? false;
  }

  List<String> getList(String key) {
    return _pref.getStringList(key) ?? <String>[];
  }
}
