import 'package:chatapp_firebase/pages/contact/controller.dart';
import 'package:get/get.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
