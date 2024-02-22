// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomRoundSelector extends StatelessWidget {
  final void Function()? onTap;
  final Widget icon;
  const CustomRoundSelector({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: const Color.fromARGB(255, 235, 39, 229),
        height: 6.h,
        width: 14.w,
        child: Material(
          shape: const CircleBorder(),
          color: Colors.white,
          child: InkWell(onTap: onTap, child: icon),
        ),
      ),
    );
  }
}
