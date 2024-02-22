import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;

  final void Function() onTap;
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.alignment,
    required this.fontWeight,
    required this.fontSize,
    required this.fontColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
