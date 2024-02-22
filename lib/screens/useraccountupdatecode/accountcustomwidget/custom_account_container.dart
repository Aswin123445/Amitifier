// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAccountWidget extends StatelessWidget {
  final Widget? child;
  const CustomAccountWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3.h),
      clipBehavior: Clip.hardEdge,
      height: 8.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(157, 225, 214, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 85, 82, 85),
        ),
      ),
      child: child,
    );
  }
}
