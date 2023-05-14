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

  var listener;

  @override
  void onInit() {
    super.onInit();

    // Parameters
    var params = Get.parameters;
    docId = params['doc_id'] ?? '';
    state.toUid.value = params['to_uid'] ?? '';
    state.toName.value = params['to_name'] ?? '';
    state.toAvatar.value = params['to_avatar'] ?? '';
  }

  @override
  void dispose() {
    msgScrollController.dispose();
    listener.cancel();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    var messages = db
        .collection("messages")
        .doc(docId)
        .collection("msgList")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent model, options) => model.toFirestore(),
        )
        .orderBy("addtime", descending: true);

    // Clear earlier messages
    state.msgContentList.clear();

    // Listening all types of changes in "messages" collection
    // -----------------------------------------------------------------------------------------------------------------------
    // event means all Documents in the collection
    listener = messages.snapshots().listen(
      (event) {
        // event.docChanges --> An array of the documents that changed since the last snapshot
        // So only checks the changed docs and skips all other
        for (var change in event.docChanges) {
          switch (change.type) {
            //
            // case : listen to new item added to the document, item may be a property or a sub-collection
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                // Insert at 0th position, in order to make it as first item, otherwise it will added to last (like, if add() method is using)
                state.msgContentList.insert(0, change.doc.data()!);
              }
              break;

            // case : listen to removing item from the document
            case DocumentChangeType.removed:
              break;

            // case : listen to modifying an item from the document
            case DocumentChangeType.modified:
              break;
          }
        }
      },
      onError: (error) => print('Listen failed : $error'),
    );

    // -----------------------------------------------------------------------------------------------------------------------
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
