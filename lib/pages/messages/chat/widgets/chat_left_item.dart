import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/pages/messages/chat/model/msg_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget chatLeftItem(Msgcontent msg) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(      
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 230.w,
            minHeight: 40.w,
          ),
          child: Container(
            margin: EdgeInsets.only(right: 10.w),
            padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 176, 106, 231),
                Color.fromARGB(255, 166, 112, 231),
                Color.fromARGB(255, 131, 123, 231),
                Color.fromARGB(255, 104, 132, 231),
              ], transform: GradientRotation(90)),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: msg.type == 'text'
                ? Text('${msg.content}')
                : ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 90.w),
                    child: GestureDetector(
                      onTap: () {},
                      child: CachedNetworkImage(imageUrl: '${msg.content}'),
                    ),
                  ),
          ),
        )
      ],
    ),
  );
}
