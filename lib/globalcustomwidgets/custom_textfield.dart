// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color color;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  const CustomTextFormField({
    Key? key,
    this.prefixIcon,
    this.hintText,
    this.onChanged,
    this.validator,
    required this.controller,
    this.contentPadding,
    required this.obscureText,
    this.keyboardType,
    required this.color,
    required this.textInputAction,
    this.focusNode,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 209, 79, 226),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 98, 14, 105),
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
        color: color,
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        textInputAction: textInputAction,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          errorStyle: TextStyle(
            color: const Color.fromARGB(255, 194, 67, 32),
            letterSpacing: 1.sp,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w500,
          ),
          suffix: suffixIcon,
          border: InputBorder.none,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
