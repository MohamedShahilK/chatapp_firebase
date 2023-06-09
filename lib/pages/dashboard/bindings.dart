import 'package:chatapp_firebase/pages/contact/controller.dart';
import 'package:chatapp_firebase/pages/dashboard/controller.dart';
import 'package:get/get.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
