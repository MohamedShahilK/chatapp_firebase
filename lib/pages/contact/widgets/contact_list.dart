import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/pages/contact/controller.dart';
import 'package:chatapp_firebase/pages/contact/model/contact_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = controller.state.contactList[index];
                  return _buildListItem(item);
                },
                childCount: controller.state.contactList.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(ContactUserModel item) {
    // print(controller.state.contactList.length);
    return Container(
      padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 0.w),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 15.w),
              width: 54.w,
              height: 54.w,
              child: CachedNetworkImage(imageUrl: "${item.photourl}"),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.w),
              width: 250.w,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xffe5efe5)),
                ),
              ),
              child: SizedBox(
                width: 200.w,
                height: 42.w,
                child: Text(
                  "${item.name}",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
