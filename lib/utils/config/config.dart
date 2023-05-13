import 'package:chatapp_firebase/utils/services/storage_services.dart';
import 'package:get/get.dart';

import 'package:chatapp_firebase/utils/design_items/values/values.dart';

// we can use "to" to access the methods and variables inside of the class
class Config extends GetxController {
  // important
  static Config get to => Get.find();

  bool isFirstOpen = true;

  @override
  void onInit() {
    super.onInit();
    isFirstOpen = StorageServices.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  }

  // function used to remembering the device that app is already opened , (ie; it is nt the first time)
  Future<bool> saveAlreadyOpened() {
    // saveAlreadyOpened means we have to assign "isFirstOpen" to "false"
    return StorageServices.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, false);
  }
}
