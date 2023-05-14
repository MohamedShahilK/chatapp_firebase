// ignore_for_file: avoid_print

import 'package:chatapp_firebase/pages/contact/model/contact_user_model.dart';
import 'package:chatapp_firebase/pages/contact/state.dart';
import 'package:chatapp_firebase/utils/config/user_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final state = ContactState();

  final db = FirebaseFirestore.instance;
  final userToken = UserConfig.to.token;

  @override
  void onReady() {
    super.onReady();
    loadAllOtherUsersFromFireBase();
  }

  loadAllOtherUsersFromFireBase() async {
    try {
      final allOtherUsers = await db
          .collection("users")
          .where("id", isNotEqualTo: userToken)
          .withConverter(
            fromFirestore: ContactUserModel.fromFirestore,
            toFirestore: (ContactUserModel model, options) =>
                model.toFirestore(),
          )
          .get();
      print(allOtherUsers.docs.length);
      for (var doc in allOtherUsers.docs) {
        state.contactList.add(doc.data());
      }
    } catch (e) {
      print(e);
    }
  }
}
