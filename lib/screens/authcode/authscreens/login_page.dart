import 'package:animate_do/animate_do.dart';
import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/globalcustomwidgets/cutom_elevated_button.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:animated_login/services/textfield_validators/register_validator.dart';
import 'package:animated_login/globalcustomwidgets/text_button.dart';
import 'package:animated_login/screens/authcode/authscreens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, RegisterScreen.routeName);
  }

  final _formKey = GlobalKey<FormState>();

  final RegisterValidator loginValidation = RegisterValidator();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  late bool isIconTab = false;
  late bool isEmailFocus = false;
  late bool isPasswordFocus = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthServices authServices = FirebaseAuthServices();

  void setEmailFocus() {
    isEmailFocus = emailFocusNode.hasFocus;
  }

  void setPasswordFocus() {
    isPasswordFocus = passwordFocusNode.hasFocus;
  }

  @override
  void initState() {
    emailFocusNode.addListener(() {
      setState(() {
        setEmailFocus();
      });
    });
    passwordFocusNode.addListener(() {
      setState(() {
        setPasswordFocus();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    mailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          child: Container(
            height: 100.h,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      height: 37.h,
                      child: Lottie.asset('asset/animations/signin.json')),
                  Row(
                    children: [
                      Center(
                        child: FadeInDown(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 700),
                          child: CustomText(
                            text: 'Welcome',
                            containerWidth: 48.w,
                            size: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Center(
                        child: FadeInDown(
                            delay: const Duration(milliseconds: 600),
                            duration: const Duration(milliseconds: 800),
                            child: CustomText(
                                containerWidth: 25.w,
                                text: 'back',
                                size: 30.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 900),
                        duration: const Duration(milliseconds: 800),
                        child: CustomText(
                          text: '!',
                          size: 30.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 191, 16, 239),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      FadeInDown(
                        delay: const Duration(milliseconds: 350),
                        duration: const Duration(milliseconds: 700),
                        child: CustomText(
                            containerWidth: 17.5.w,
                            text: '  Let',
                            size: 24.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 900),
                        duration: const Duration(milliseconds: 800),
                        child: CustomText(
                          containerWidth: 7.w,
                          text: '\'s',
                          size: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 191, 16, 239),
                        ),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 750),
                        child: Text(
                          ' get ',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 800),
                        child: CustomText(
                            containerWidth: 22.w,
                            text: ' started',
                            size: 24.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      FadeInRight(
                        delay: const Duration(milliseconds: 900),
                        duration: const Duration(milliseconds: 600),
                        child: CustomText(
                          containerWidth: 2.w,
                          text: '.',
                          size: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 191, 16, 239),
                        ),
                      ),
                      FadeInRight(
                        delay: const Duration(milliseconds: 950),
                        duration: const Duration(milliseconds: 700),
                        child: CustomText(
                          containerWidth: 2.w,
                          text: '.',
                          size: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 191, 16, 239),
                        ),
                      ),
                      FadeInRight(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 800),
                        child: CustomText(
                          containerWidth: 2.w,
                          text: '.',
                          size: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 191, 16, 239),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        containerWidth: 20.w,
                        text: 'Gamil',
                        size: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CustomTextFormField(
                    controller: mailController,
                    color: isEmailFocus
                        ? Colors.white
                        : const Color.fromARGB(250, 247, 239, 250),
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    focusNode: emailFocusNode,
                    contentPadding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                    validator: (value) {
                      return loginValidation.emailValidator(value);
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        text: 'Password',
                        containerWidth: 28.w,
                        size: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    obscureText: isIconTab,
                    color: isPasswordFocus
                        ? Colors.white
                        : const Color.fromARGB(250, 247, 239, 250),
                    textInputAction: TextInputAction.done,
                    focusNode: passwordFocusNode,
                    contentPadding:
                        EdgeInsets.only(left: 2.w, bottom: .7.h, right: 3.w),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isIconTab = !isIconTab;
                        });
                      },
                      child: isIconTab
                          ? Icon(
                              Icons.visibility_off,
                              size: 19.sp,
                            )
                          : Icon(
                              Icons.visibility,
                              size: 19.sp,
                            ),
                    ),
                    validator: (value) {
                      return loginValidation.passwordValidator(value);
                    },
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  CustomElavatedButton(
                    elevation: MaterialStateProperty.all<double>(8.sp),
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    text: 'Sign In',
                    fontWeight: FontWeight.bold,
                    fontSize: 21.sp,
                    fontColor: Colors.black,
                    width: double.infinity,
                    height: 6.h,
                    onPress: () async {
                      User? user =
                          await authServices.signinWithEmailandPassword(
                              mailController.text, passwordController.text);
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomText(
                          containerWidth: 53.w,
                          text: 'don\'t have an account ??',
                          size: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 7.5.h,
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 1600),
                          child: SizedBox(
                            height: 5.h,
                            width: 25.w,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: CustomTextButton(
                                text: 'Register',
                                alignment: Alignment.topLeft,
                                fontWeight: FontWeight.w400,
                                fontSize: 0.sp,
                                fontColor:
                                    const Color.fromARGB(212, 161, 0, 161),
                                onTap: () {
                                  navigateToRegisterPage(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
