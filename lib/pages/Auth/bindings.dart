import 'package:chatapp_firebase/pages/Auth/controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
