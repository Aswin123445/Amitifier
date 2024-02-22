// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';

class CustomInkwellButton extends StatelessWidget {
  final double? containerWidth;
  final String text;
  final void Function()? ontap;
  const CustomInkwellButton({
    Key? key,
    this.containerWidth,
    required this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(top: 2.h),
      height: 7.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 212, 212),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: const Color.fromARGB(255, 215, 2, 215),
        ),
      ),
      child: Material(
        color: const Color.fromARGB(204, 2, 183, 123),
        child: InkWell(
          splashColor: const Color.fromARGB(133, 218, 20, 236),
          onTap: ontap,
          child: Padding(
            padding: EdgeInsets.only(top: 1.5.h, left: 6.5.w),
            child: Center(
              child: CustomText(
                containerWidth: containerWidth ?? 30.w,
                text: text,
                size: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
