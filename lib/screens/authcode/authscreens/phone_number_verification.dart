import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/cutom_elevated_button.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class PhoneNumberVerification extends StatefulWidget {
  //verifaction id firebase send to our application

  static const routeName = '/phonenumberVerification';

  const PhoneNumberVerification({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuthServices services = FirebaseAuthServices();
  bool loadChecker = false;
  final myFocust = FocusNode();
  bool isNumberFocus = false;

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  bool roundController = false;

  @override
  void dispose() {
    initState();
    super.dispose();
  }

  void setNumberFocus() {
    isNumberFocus = myFocust.hasFocus;
  }

  @override
  void initState() {
    myFocust.addListener(() {
      setState(() {
        setNumberFocus();
      });
    });
    super.initState();
  }

  Country? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    if (country == null) {
      setState(() {
        initCountry();
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 100.w,
                    child: Lottie.asset(
                      'asset/animations/otp.json',
                      height: 20.h,
                      width: 30.w,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      'You allmost there',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 196, 10, 174)),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Center(
                    child: Text(
                      ' Verify Phone Number !',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 8.5.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 224, 144, 225)
                              .withOpacity(.5.sp),
                          spreadRadius: .9,
                          blurRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        width: .7.sp,
                        color: const Color.fromARGB(255, 169, 30, 233),
                      ),
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromARGB(237, 218, 244, 252),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.sp),
                          margin: EdgeInsets.only(left: 2.w),
                          height: 4.5.h,
                          width: 14.w,
                          child: country == null
                              ? Container()
                              : Image.asset(
                                  country.flag,
                                  package: countryCodePackageName,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: CustomText(
                            text: '${country?.callingCode}:',
                            size: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 1.8.h, top: 1.h, left: .5.w),
                          height: 6.5.h,
                          width: 51.w,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(bottom: BorderSide(width: 1.sp))),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorWidth: 1.sp,
                            focusNode: myFocust,
                            cursorHeight: 15.sp,
                            showCursor: true,
                            validator: isNumberFocus
                                ? null
                                : (value) {
                                    final regex = RegExp(r"^\d{10}$");
                                    if (value!.isEmpty) {
                                      return 'must contain number';
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return 'must be a phone number';
                                    }
                                    return null;
                                  },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Phonenumber',
                              errorStyle: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(
                                  fontSize: 9.sp, fontWeight: FontWeight.w600),
                            ),
                            controller: phoneController,
                            style:
                                TextStyle(fontSize: 13.sp, wordSpacing: 2.sp),
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => onPressedShowBottomSheet(),
                      child: CustomText(
                        containerWidth: 35.w,
                        text: 'Change Country?',
                        size: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 217, 12, 220),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  if (roundController == true)
                    Container(
                      color: const Color.fromARGB(255, 236, 67, 180),
                      height: 6.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 1.h),
                      width: 70.w,
                      child: const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  if (roundController == false)
                    CustomElavatedButton(
                      text: 'Send OTP',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      fontColor: Colors.black,
                      width: 70.w,
                      height: 6.h,
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            roundController = true;
                          });
                          String number =
                              '${country?.callingCode}${phoneController.text}';
                          services.linkPhoneNumber(context, number);
                        }
                        setState(() {
                          roundController = false;
                        });
                      },
                    ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}
