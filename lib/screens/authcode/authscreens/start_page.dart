import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/authcode/authscreens/login_page.dart';
import 'package:animated_login/screens/authcode/authscreens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loadchecker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                  top: 2.h,
                  left: 2.w,
                  right: 2.w,
                  bottom: 1.h,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: [
                      Image.asset(
                        'asset/images/loginimage(1).png',
                        width: 100.w,
                        height: 50.h,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 37.w, top: 20.5.h),
                          height: 15.h,
                          child: LottieBuilder.asset(
                              'asset/animations/friends.json')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 202, 19, 184),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 233, 30, 220),
                          blurRadius: 4.sp)
                    ],
                    borderRadius: BorderRadius.circular(20.sp),
                    color: const Color.fromARGB(255, 250, 249, 249)),
                padding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 2.h),
                width: 90.w,
                height: 17.7.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'AMITYFIER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: .9.h,
                    ),
                    const Text(
                      'Place that helps you to make',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Divider(
                      indent: 3.w,
                      endIndent: 3.w,
                      thickness: .3.w,
                      color: const Color.fromARGB(255, 131, 110, 167),
                    ),
                    const Text(
                      'Bonds Strong',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.red,
                onTap: () {
                  setState(() {
                    loadchecker = true;
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(166, 143, 112, 255),
                      borderRadius: BorderRadius.circular(10.sp)),
                  margin: EdgeInsets.only(top: 2.h),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.w, top: .4.h),
                  height: 5.5.h,
                  width: 65.w,
                  child: loadchecker == false
                      ? CustomText(
                          text: 'Sign In',
                          size: 17.sp,
                          fontWeight: FontWeight.bold,
                          containerWidth: 30.w,
                        )
                      : Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: const CircularProgressIndicator(
                            color: Colors.green,
                          )),
                ),
              ),
              SizedBox(
                height: .1.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 9.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'n have an account?',
                      style: TextStyle(
                          fontSize: 3.8.w,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 125, 124, 124),
                          fontFamily: 'Satoshi'),
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 21.w,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                            (Route<dynamic> route) =>
                                false, // Remove all previous routes
                          );
                        },
                        child: Text(
                          'Regiser',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 170, 93, 209),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: 7.h,
                width: 33.w,
                child: Lottie.asset('asset/animations/hands.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
