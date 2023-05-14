import 'package:chatapp_firebase/pages/contact/model/contact_user_model.dart';
import 'package:get/get.dart';

class ContactState {
  var count = 0.obs;
  // var contactList = <ContactUserModel>[].obs;
  RxList<ContactUserModel> contactList = <ContactUserModel>[].obs;
}
