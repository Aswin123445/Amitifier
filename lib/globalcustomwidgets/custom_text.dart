// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? containerWidth;
  final double? containderHeight;
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  const CustomText({
    Key? key,
    required this.text,
    this.containerWidth,
    this.containderHeight,
    required this.size,
    required this.fontWeight,
    this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containderHeight ?? 6.h,
      width: containerWidth ?? 10.w,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          overflow: overflow,
        ),
      ),
    );
  }
}
