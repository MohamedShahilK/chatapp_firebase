import 'package:chatapp_firebase/utils/services/storage_services.dart';
import 'package:get/get.dart';

import 'package:chatapp_firebase/utils/design_items/values/values.dart';

// we can use "to" to access the methods and variables inside of the class
class Config extends GetxController {
  // important
  static Config get to => Get.find();

  bool isFirstOpen = false;

  @override
  void onInit() {
    super.onInit();
    isFirstOpen = StorageServices.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  }

  Future<bool> saveAlreadyOpen() {
    return StorageServices.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, true);
  }
}
