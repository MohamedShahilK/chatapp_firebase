// This file for dependency injection

// import 'package:chatapp_firebase/pages/welcome/controller.dart';
import 'package:chatapp_firebase/pages/welcome/index.dart';

import 'package:get/get.dart';

class WelcomeBinding extends Bindings {
  // Here Loading controllers we want
  @override
  void dependencies() {
    // Get.lazyPut<Type>(() => Controller());
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
