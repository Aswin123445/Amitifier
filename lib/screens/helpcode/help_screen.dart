import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_inkwell_widget.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelpScreen extends StatefulWidget {
  static const router = '/help-screen';
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  void navigateToHomePageBody() {
    Navigator.pushNamed(context, HomeScreen.routerName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 2.h),
                    child: CustomText(
                      text: 'Amitifier',
                      size: 25.sp,
                      containerWidth: 40.w,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 218, 4, 210),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1, top: 2.h),
                    child: CustomText(
                      text: '!',
                      size: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 23, 22, 23),
                    ),
                  ),
                ],
              ),
              Container(
                height: 35.h,
                width: 100.w,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 1.w,
                  top: 1.h,
                ),
                child: CustomText(
                  text:
                      'amifier a solution for maintaining friendship. It notifiy you with the big days of your favourite ones so that you can let them know you care for them.\nYou can also save importent events,programs that you must attend in the future and you will be reminded one day before that. so you won\'t miss any events!\nuser can save the memories of friends that they have spend time in the past so the memoryies always there as colourfull as it was',
                  size: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 99, 96, 96),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
                height: 23.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(172, 187, 183, 183),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.sp),
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Home Page',
                      containerWidth: 60.w,
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: .6.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: CustomText(
                        containerWidth: 60.w,
                        text: 'You can get basic info about app from home page',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 99, 96, 96),
                      ),
                    ),
                    Center(
                      child: CustomInkwellButton(
                        text: 'Home Page',
                        ontap: navigateToHomePageBody,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
