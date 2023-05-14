// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:chatapp_firebase/pages/Auth/models/user_login.dart';
import 'package:chatapp_firebase/pages/contact/model/contact_user_model.dart';
import 'package:chatapp_firebase/pages/contact/model/message.dart';
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

  //
  goChat(ContactUserModel toUser) async {
    //
    // Both messagesBySender and messagesByReceiver are different documents, but both contains same message data
    //
    // Get document with from_uid as sendersId  (Based on Sender)
    var messagesBySender = await db
        .collection("messages")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg model, options) => model.toFirestore(),
        )
        .where("from_uid", isEqualTo: userToken) // userToken = fromUser's id
        .where("to_uid", isEqualTo: toUser.id)
        .get();

    // Get document with from_uid as sendersId  (Based on Receiver)
    var messagesByReceiver = await db
        .collection("messages")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg model, options) => model.toFirestore(),
        )
        .where("from_uid", isEqualTo: toUser.id)
        .where("to_uid", isEqualTo: userToken) // userToken = fromUser's id
        .get();

    if (messagesBySender.docs.isEmpty && messagesByReceiver.docs.isEmpty) {
      String profile = await UserConfig.to.getProfile();
      UserLoginModel mainUser = UserLoginModel.fromJson(jsonDecode(profile));

      var messageData = Msg(
        from_uid: mainUser.accessToken,
        to_uid: toUser.id,
        from_name: mainUser.displayName,
        to_name: toUser.name,
        from_avatar: mainUser.photoUrl,
        to_avatar: toUser.photourl,
        last_msg:
            "", // There is no messages between them, because it is first time
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      await db
          .collection("messages")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg model, options) => model.toFirestore(),
          )
          .add(messageData)
          .then((value) {
        Get.toNamed('/chat', parameters: {
          "doc_id": value.id,
          "to_uid": toUser.id ?? '',
          "to_name": toUser.name ?? '',
          "to_avatar": toUser.photourl ?? '',
        });
      });
    } else {
      if (messagesBySender.docs.isNotEmpty) {
         Get.toNamed('/chat', parameters: {
          "doc_id": messagesBySender.docs.first.id,
          "to_uid": toUser.id ?? '',
          "to_name": toUser.name ?? '',
          "to_avatar": toUser.photourl ?? '',
        });
      }
      if (messagesByReceiver.docs.isNotEmpty) {
         Get.toNamed('/chat', parameters: {
          "doc_id": messagesByReceiver.docs.first.id,
          "to_uid": toUser.id ?? '',
          "to_name": toUser.name ?? '',
          "to_avatar": toUser.photourl ?? '',
        });
      }
    }
  }
}
