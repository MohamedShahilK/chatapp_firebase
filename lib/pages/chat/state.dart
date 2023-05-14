import 'package:chatapp_firebase/pages/chat/model/msg_content.dart';
import 'package:get/get.dart';

class ChatState {
  RxList<Msgcontent> msgContentList = <Msgcontent>[].obs;
  var toUid = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var toLocation = "unknown".obs;
}
