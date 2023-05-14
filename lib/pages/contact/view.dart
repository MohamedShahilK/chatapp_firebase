import 'package:chatapp_firebase/pages/contact/controller.dart';
import 'package:chatapp_firebase/pages/contact/widgets/contact_list.dart';
import 'package:chatapp_firebase/utils/design_items/values/colors.dart';
import 'package:chatapp_firebase/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // print(controller.state.contactList.length);  
    return Scaffold(
      appBar: _buildAppBar(),
      body: const ContactList(),
    );
  }

  AppBar _buildAppBar() {
    return customTransparentAppBar(
      title: Text(
        'Contact',
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
