// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String otpverifier;
  const OtpVerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.otpverifier,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  FirebaseAuthServices services = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
              child: Lottie.asset('asset/animations/verify.json'),
            ),
            Center(
              child: CustomText(
                text: ' Verify OTP',
                containderHeight: 7.h,
                containerWidth: 60.w,
                size: 30.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 203, 14, 216),
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Container(
              width: 70.w,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(138, 179, 230, 252),
                  border: Border.all(
                    color: const Color.fromARGB(255, 210, 11, 207),
                    width: 1.5.sp,
                  ),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Center(
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 2.w),
                      hintText: '       enter otp',
                      hintStyle: TextStyle(fontSize: 20.sp),
                      border: InputBorder.none),
                  onChanged: (value) {
                    if (value.length == 6) {
                      services.verifyOtp(
                        context: context,
                        varificationId: widget.otpverifier,
                        userOtp: value,
                        phoneNumber: widget.phoneNumber,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
