import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/pages/chat/controller.dart';
import 'package:chatapp_firebase/pages/chat/widgets/chat_list.dart';
import 'package:chatapp_firebase/utils/design_items/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              title: const Text('Gallery'),
              leading: const Icon(Icons.photo_library),
              onTap: () {
                controller.imgFromGallery();
                // It has the advantage of not needing context, so you can call from your business logic.
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Gallery'),
              leading: const Icon(Icons.photo_library),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.state.contactList.length);
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              //
              // Chat Section
              const ChatList(),

              // Bottom Section
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  width: 360.w,
                  height: 50.h,
                  color: AppColors.primaryBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TextField
                      SizedBox(
                        width: 217.w,
                        height: 50.h,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: controller.textEditingController,
                          autofocus: false,
                          focusNode: controller.focusNode,
                          decoration: const InputDecoration(
                            hintText: "Send messages...",
                          ),
                        ),
                      ),

                      // Photo Icon Button
                      Container(
                        height: 30.h,
                        width: 30.w,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          child: Icon(
                            Icons.photo_outlined,
                            size: 35.w,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),

                      // Send Button
                      Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        width: 65.w,
                        height: 35.h,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.sendMessage();
                          },
                          child: const Text("Send"),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // appbar
  //when "Widget" is used as return type for AppBar, then we have to given "PreferredSize" as parent of AppBar
  // Widget _buildAppBar() {
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 176, 106, 231),
            Color.fromARGB(255, 166, 112, 231),
            Color.fromARGB(255, 131, 123, 231),
            Color.fromARGB(255, 104, 132, 231),
          ], transform: GradientRotation(90)),
        ),
      ),
      title: Row(
        children: [
          // User Avatar / image
          InkWell(
            child: SizedBox(
              width: 44.w,
              height: 44.w,
              child: CachedNetworkImage(
                imageUrl: controller.state.toAvatar.value,
                // This make the image Round.
                imageBuilder: (context, imageProvider) => Container(
                  width: 44.w,
                  height: 44.w,
                  margin: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44.w),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // errorWidget: (context, url, error) => Image.asset('assets/images/feature-1.png'),
                errorWidget: (context, url, error) => const Image(
                  image: AssetImage('assets/images/feature-1.png'),
                ),
              ),
            ),
          ),

          // space
          SizedBox(width: 15.w),

          // User's Name and Location
          SizedBox(
            width: 180.w,
            child: SizedBox(
              width: 180.w,
              height: 44.w,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.state.toName.value,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackground,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      controller.state.toLocation.value,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackground,
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
