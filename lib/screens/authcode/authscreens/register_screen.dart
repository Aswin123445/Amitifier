import 'package:animate_do/animate_do.dart';
import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/globalcustomwidgets/cutom_elevated_button.dart';
import 'package:animated_login/globalcustomwidgets/text_button.dart';
import 'package:animated_login/screens/authcode/authscreens/login_page.dart';
import 'package:animated_login/screens/authcode/authscreens/phone_number_verification.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:animated_login/services/textfield_validators/register_validator.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void navigateToLoginScreen() {
    Navigator.pushNamed(
      context,
      LoginScreen.routeName,
    );
  }

  void navigateToPhoneScreen() {
    Navigator.pushNamed(
      context,
      PhoneNumberVerification.routeName,
    );
  }

  RegisterValidator validator = RegisterValidator();
  FocusNode nameFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode conformPasswordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  bool isNameFocus = false;
  bool ismailFocus = false;
  bool isPasswordFocus = false;
  bool isConformPasswordFocus = false;
  bool iconPasswordTab = false;
  bool iconConformPasswordTab = false;
  FirebaseAuthServices authServices = FirebaseAuthServices();
  bool signRound = false;

  void setNameFocus() {
    isNameFocus = nameFocus.hasFocus;
  }

  void setMailFocus() {
    ismailFocus = mailFocus.hasFocus;
  }

  void setPasswordFocus() {
    isPasswordFocus = passwordFocus.hasFocus;
  }

  void setConformPasswordFocus() {
    isConformPasswordFocus = conformPasswordFocus.hasFocus;
  }

  @override
  void initState() {
    nameFocus.addListener(() {
      setState(() {
        setNameFocus();
      });
      mailFocus.addListener(() {
        setState(() {
          setMailFocus();
        });
      });
      passwordFocus.addListener(() {
        setState(() {
          setPasswordFocus();
        });
      });
      conformPasswordFocus.addListener(() {
        setState(() {
          setConformPasswordFocus();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0.h),
          color: Colors.white,
          height: 94.62.h,
          width: 100.w,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    height: 28.h,
                    width: 75.w,
                    child: Lottie.asset('asset/animations/register.json',
                        width: 70.w, height: 30.h),
                  ),
                  SizedBox(
                    height: 6.6.h,
                    child: Row(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 500),
                          child: CustomText(
                            text: 'J',
                            size: 29.sp,
                            containerWidth: 6.w,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 191, 16, 239),
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 500),
                          child: CustomText(
                            text: 'o',
                            size: 25.sp,
                            containerWidth: 5.5.w,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 500),
                          child: CustomText(
                            text: 'i',
                            size: 25.sp,
                            containerWidth: 2.w,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 191, 16, 239),
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            text: 'n',
                            containerWidth: 6.w,
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 600),
                          child: CustomText(
                            text: 'our',
                            containerWidth: 18.w,
                            size: 29.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 900),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            text: 'fam',
                            containerWidth: 18.5.w,
                            size: 29.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 900),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            containerWidth: 2.w,
                            text: 'i',
                            size: 29.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 191, 16, 239),
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 900),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            containderHeight: 6.5.h,
                            text: 'ly',
                            size: 29.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 5.5.h,
                    child: Row(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 500),
                          child: CustomText(
                            text: 'let',
                            containerWidth: 11.w,
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 750),
                          delay: const Duration(milliseconds: 1100),
                          child: CustomText(
                            text: '\'s',
                            containerWidth: 8.w,
                            size: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 191, 16, 239),
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 600),
                          child: CustomText(
                            text: 'make',
                            containerWidth: 25.w,
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 900),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            text: 'our',
                            containerWidth: 20.w,
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    color: Colors.white,
                    height: 8.h,
                    child: Row(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 600),
                          child: CustomText(
                            containerWidth: 24.w,
                            text: 'loved',
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 900),
                          delay: const Duration(milliseconds: 700),
                          child: CustomText(
                            containerWidth: 20.w,
                            text: 'ones',
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 800),
                          child: CustomText(
                            text: 'happy',
                            containerWidth: 27.w,
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        FadeInDown(
                          duration: const Duration(milliseconds: 550),
                          delay: const Duration(milliseconds: 1400),
                          child: CustomText(
                            text: '!',
                            size: 25.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 191, 16, 239),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: .1.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        containerWidth: 20.w,
                        text: 'Name:',
                        size: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    color: Colors.white,
                    height: 8.h,
                    child: CustomTextFormField(
                      contentPadding: EdgeInsets.only(left: 3.w),
                      validator: (value) {
                        return validator.nameValidator(value);
                      },
                      controller: nameController,
                      obscureText: false,
                      color: isNameFocus
                          ? Colors.white
                          : const Color.fromARGB(250, 247, 239, 250),
                      textInputAction: TextInputAction.next,
                      focusNode: nameFocus,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        containerWidth: 20.w,
                        text: 'Gmail:',
                        size: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    color: Colors.white,
                    height: 8.h,
                    child: CustomTextFormField(
                      controller: mailController,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      obscureText: false,
                      color: ismailFocus
                          ? Colors.white
                          : const Color.fromARGB(250, 247, 239, 250),
                      textInputAction: TextInputAction.next,
                      focusNode: mailFocus,
                      validator: (mail) {
                        return validator.emailValidator(mail);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        containerWidth: 27.w,
                        text: 'Password:',
                        size: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    color: Colors.white,
                    height: 8.h,
                    child: CustomTextFormField(
                      contentPadding: EdgeInsets.only(left: 3.w),
                      controller: passwordController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            iconPasswordTab = !iconPasswordTab;
                          });
                        },
                        child: iconPasswordTab
                            ? Padding(
                                padding: EdgeInsets.only(right: 3.w, top: 2.h),
                                child: Icon(
                                  Icons.visibility,
                                  size: 22.sp,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(right: 3.w, top: 2.h),
                                child: Icon(
                                  Icons.visibility_off,
                                  size: 22.sp,
                                ),
                              ),
                      ),
                      obscureText: !iconPasswordTab,
                      color: isPasswordFocus
                          ? Colors.white
                          : const Color.fromARGB(250, 247, 239, 250),
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocus,
                      validator: (password) {
                        return validator.passwordValidator(password);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        containerWidth: 70.w,
                        text: 'Conform password:',
                        size: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    color: Colors.white,
                    height: 8.h,
                    child: CustomTextFormField(
                      contentPadding: EdgeInsets.only(right: 3.w, left: 3.w),
                      controller: conformPasswordController,
                      obscureText: !iconConformPasswordTab,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            iconConformPasswordTab = !iconConformPasswordTab;
                          });
                        },
                        child: iconConformPasswordTab
                            ? Icon(
                                Icons.visibility,
                                size: 22.sp,
                              )
                            : Icon(Icons.visibility_off, size: 22.sp),
                      ),
                      color: isConformPasswordFocus
                          ? Colors.white
                          : const Color.fromARGB(250, 247, 239, 250),
                      textInputAction: TextInputAction.done,
                      focusNode: conformPasswordFocus,
                      validator: (conformPassword) {
                        if (passwordController.text ==
                            conformPasswordController.text) return null;
                        return 'password did\'n match';
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (signRound == true)
                    SizedBox(
                      height: 8.h,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 67, 180),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.sp)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 2.h),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  if (signRound == false)
                    Container(
                      color: Colors.white,
                      height: 8.h,
                      child: CustomElavatedButton(
                        padding: EdgeInsets.symmetric(horizontal: 9.h),
                        text: 'Register',
                        fontWeight: FontWeight.bold,
                        fontSize: 21.sp,
                        fontColor: Colors.black,
                        width: double.infinity,
                        height: 6.h,
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              signRound = true;
                            });
                            User? user =
                                await authServices.signUpWithEmailandPassword(
                              mailController.text,
                              passwordController.text,
                              nameController.text,
                            );

                            if (user != null) {
                              authServices.setUserData(
                                mailController.text,
                                nameController.text,
                              );
                              navigateToPhoneScreen();
                            }
                          }
                        },
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(right: 13.w),
                    child: CustomTextButton(
                      text: 'Sing in??',
                      alignment: Alignment.topRight,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp,
                      fontColor: const Color.fromARGB(255, 191, 16, 239),
                      onTap: () {
                        navigateToLoginScreen();
                      },
                    ),
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
