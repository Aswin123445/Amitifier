import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/authcode/authscreens/start_page.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseAuthServices services = FirebaseAuthServices();
  bool onTouch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                  width: 60.w,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                        width: 50.w,
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Am',
                              size: 26.sp,
                              containerWidth: 15.4.w,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'i',
                              size: 26.sp,
                              containerWidth: 2.w,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 't',
                              size: 26.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 3.4.w,
                            ),
                            CustomText(
                              text: 'i',
                              size: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 2.w,
                            ),
                            CustomText(
                              text: 'f',
                              size: 26.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 3.3.w,
                            ),
                            CustomText(
                              text: 'i',
                              size: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 2.w,
                            ),
                            CustomText(
                              text: 'er',
                              size: 25.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 12.3.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                        width: 50.w,
                        child: Row(
                          children: [
                            CustomText(
                              text: 'User',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 18.w,
                            ),
                            CustomText(
                              text: 's',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 4.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                        width: 50.w,
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Wor',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 16.5.w,
                            ),
                            CustomText(
                              text: 'k ',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 7.w,
                            ),
                            CustomText(
                              text: 's',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 4.4.w,
                            ),
                            CustomText(
                              text: 'pace',
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.h),
                  height: 16.h,
                  width: 40.w,
                  child: Lottie.asset('asset/animations/setting.json',
                      height: 22.h),
                )
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      onTouch = true;
                    });
                    Future.delayed(const Duration(seconds: 3), () {
                      services.logoutUser();
                    });
                    HomeScreen.bottomNavigationBarIndex = 0;
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const StartPage();
                      },
                    ), (route) => false);
                  },
                  child: Container(
                    height: 6.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: onTouch == false
                          ? const Color.fromARGB(255, 203, 249, 254)
                          : const Color.fromARGB(255, 217, 255, 234),
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: const Color.fromARGB(255, 233, 30, 213),
                        width: 1.3.sp,
                      ),
                    ),
                    child: onTouch == false
                        ? Padding(
                            padding: EdgeInsets.only(top: .6.h, left: 5.w),
                            child: CustomText(
                                text: 'Log Out',
                                size: 15.sp,
                                fontWeight: FontWeight.bold),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.w, vertical: 1.5.h),
                            child: const CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
