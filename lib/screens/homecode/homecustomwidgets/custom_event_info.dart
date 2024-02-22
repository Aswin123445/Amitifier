// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomEventInfo extends StatelessWidget {
  final double? borderWidth;
  final double? width;
  final double? height;
  final Widget child;
  const CustomEventInfo({
    Key? key,
    this.borderWidth,
    this.width,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 44.w,
      height: height ?? 30.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(251, 244, 254, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 213, 7, 213),
          width: borderWidth ?? 1.sp,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 218, 18, 221),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}
