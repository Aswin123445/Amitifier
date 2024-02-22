// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomElavatedButton extends StatelessWidget {
  final String? text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;
  final MaterialStateProperty<double?>? elevation;
  final EdgeInsetsGeometry? padding;
  final double width;
  final Widget? child;
  final double height;
  final void Function() onPress;
  const CustomElavatedButton({
    Key? key,
    this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.fontColor,
    this.elevation,
    this.padding,
    required this.width,
    this.child,
    required this.height,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          elevation: elevation,
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 236, 67, 180),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: child ??
            Text(
              text!,
              style: TextStyle(
                  fontWeight: fontWeight, fontSize: fontSize, color: fontColor),
            ),
      ),
    );
  }
}
