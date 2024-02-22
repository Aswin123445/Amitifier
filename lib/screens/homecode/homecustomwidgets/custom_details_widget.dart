// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';

class CustomDetailsWidget extends StatelessWidget {
  final double size;
  final String headValue;
  final String head;
  const CustomDetailsWidget({
    Key? key,
    required this.size,
    required this.headValue,
    required this.head,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 2.w, top: 1.5.h),
              child: CustomText(
                text: head,
                size: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 66, 62, 62),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 1.w,
                top: 1.5.h,
              ),
              child: CustomText(
                text: headValue,
                size: size.sp,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
