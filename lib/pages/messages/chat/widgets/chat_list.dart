import 'package:chatapp_firebase/pages/messages/chat/controller.dart';
import 'package:chatapp_firebase/pages/messages/chat/widgets/chat_left_item.dart';
import 'package:chatapp_firebase/pages/messages/chat/widgets/chat_right_item.dart';
import 'package:chatapp_firebase/utils/design_items/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.chatbg,
      padding: EdgeInsets.only(bottom: 50.h),
      child: CustomScrollView(
        reverse: true,
        controller: controller.msgScrollController,
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var message = controller.state.msgContentList[index];
                  if (controller.userId == message.uid) {
                    print(message.content);
                    return chatRightItem(message);
                  }
                  return chatLeftItem(message);
                },
                childCount: controller.state.msgContentList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
