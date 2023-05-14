// ignore_for_file: avoid_print

import 'package:chatapp_firebase/pages/chat/model/msg_content.dart';
import 'package:chatapp_firebase/pages/chat/state.dart';
import 'package:chatapp_firebase/utils/config/user_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatState();

  String docId = '';

  final textEditingController = TextEditingController();
  ScrollController msgScrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  final userId = UserConfig.to.token;
  final db = FirebaseFirestore.instance;

  // Parameters
  @override
  void onInit() {
    super.onInit();
    var params = Get.parameters;
    docId = params['doc_id'] ?? '';
    state.toUid.value = params['to_uid'] ?? '';
    state.toName.value = params['to_name'] ?? '';
    state.toAvatar.value = params['to_avatar'] ?? '';
  }

  // send message function
  sendMessage() async {
    final sendContent = textEditingController.text;
    final msgContentToDB = Msgcontent(
      content: sendContent,
      uid: userId,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db
        .collection("messages")
        .doc(docId)
        .collection("msgList")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent model, options) => model.toFirestore(),
        )
        .add(msgContentToDB)
        .then((DocumentReference doc) {
      print('Document Snapshot added with id : ${doc.id}');
      textEditingController.clear();
      Get.focusScope?.unfocus();
    });

    // Update lastMessage property
    await db
        .collection("messages")
        .doc(docId)
        .update({"last_msg": sendContent, "last_time": Timestamp.now()});
  }
}
