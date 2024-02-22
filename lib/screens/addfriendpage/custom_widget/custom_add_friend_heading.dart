import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class CustomAddFriendContainer extends StatelessWidget {
  const CustomAddFriendContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: 55.w,
          height: 14.h,
          margin: EdgeInsets.only(left: 7.w, top: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    containerWidth: 19.w,
                    text: 'Add',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'fr',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 6.9.w,
                  ),
                  CustomText(
                    text: 'i',
                    containerWidth: 2.5.w,
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 181, 0, 153),
                  ),
                  CustomText(
                    text: 'en',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 10.5.w,
                  ),
                  CustomText(
                    containerWidth: 5.4.w,
                    text: 'd',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    containerWidth: 4.w,
                    text: 's',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 181, 0, 153),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: 'On',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 15.5.w,
                  ),
                  CustomText(
                    text: 'Am',
                    size: 24.sp,
                    containerWidth: 14.4.w,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'i',
                    size: 24.sp,
                    containerWidth: 2.w,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 181, 0, 153),
                  ),
                  CustomText(
                    text: 't',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 3.4.w,
                  ),
                  CustomText(
                    text: 'i',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 181, 0, 153),
                    containerWidth: 2.w,
                  ),
                  CustomText(
                    text: 'f',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 3.3.w,
                  ),
                  CustomText(
                    text: 'i',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 181, 0, 153),
                    containerWidth: 2.w,
                  ),
                  CustomText(
                    text: 'er',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 12.3.w,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 3.w,
          ),
          height: 20.h,
          width: 30.w,
          child: Lottie.asset('asset/animations/friends.json'),
        )
      ],
    );
  }
}
