import 'dart:io';

import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/globalcustomwidgets/cutom_elevated_button.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ProfileUbdateScreen extends StatefulWidget {
  static const routerName = '/profile-Ubdate-Screen';
  const ProfileUbdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileUbdateScreen> createState() => _ProfileUbdateScreenState();
}

class _ProfileUbdateScreenState extends State<ProfileUbdateScreen> {
  final TextEditingController changeNickName = TextEditingController();
  final TextEditingController changeOccupation = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuthServices services = FirebaseAuthServices();
  String? url;

  String? currentDate = 'Select DOB';
  File? selectedImage;
  DateTime? currentDateInDateFormat;
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: const Color(0x00FFF6EF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.sp),
          topRight: Radius.circular(30.sp),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  url = await services.profilePhoto(xFile!.name, xFile!);
                  setState(() {});
                  services.addImageToUserData(url!);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: Lottie.asset(
                    'asset/animations/update.json',
                    height: 11.h,
                    width: 22.w,
                  ),
                ),
              ),
              Stack(
                children: [
                  if (selectedImage == null)
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 4.w),
                      child: Container(
                        height: 11.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 229, 226, 226),
                          // color: const Color.fromARGB(255, 186, 179, 179),
                          border: Border.all(
                              color: const Color.fromARGB(255, 219, 3, 223),
                              width: 1.5.sp),
                        ),
                        child: Image.asset(
                          'asset/images/accountmale.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  if (selectedImage != null)
                    Container(
                      margin: EdgeInsets.fromLTRB(5.w, 3.4.h, 1.w, 1.h),
                      child: CircleAvatar(
                        radius: 36.sp,
                        backgroundImage: FileImage(selectedImage!),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.fromLTRB(22.w, 9.h, 1.w, 1.h),
                    width: 10.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 225, 225),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        pickImageFromGalllery();
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 6.h),
                padding: EdgeInsets.only(left: 4.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: CustomTextFormField(
                        validator: (p0) {
                          RegExp integerRegex = RegExp(r'^-?\d+$');
                          if (p0!.isEmpty) {
                            return 'this field cannot be null';
                          } else if (integerRegex.hasMatch(p0)) {
                            return 'letters only';
                          }

                          return null;
                        },
                        controller: changeNickName,
                        obscureText: false,
                        color: Colors.white,
                        textInputAction: TextInputAction.done,
                        hintText: 'Nick Name',
                        contentPadding: EdgeInsets.only(left: 3.w),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: CustomTextFormField(
                        validator: (p0) {
                          RegExp integerRegex = RegExp(r'^-?\d+$');
                          if (p0!.isEmpty) {
                            return 'this field cannot be null';
                          } else if (integerRegex.hasMatch(p0)) {
                            return 'letters only';
                          }

                          return null;
                        },
                        controller: changeOccupation,
                        obscureText: false,
                        color: Colors.white,
                        textInputAction: TextInputAction.done,
                        hintText: 'Current Occupation',
                        contentPadding: EdgeInsets.only(left: 3.w),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 209, 79, 226),
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 98, 14, 105),
                                blurRadius: 4,
                                spreadRadius: 1)
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(currentDate!),
                            Padding(
                              padding: EdgeInsets.only(left: 27.w, right: 5.w),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    selectCurrentDate(context);
                                  },
                                  child:
                                      Lottie.asset('asset/animations/dob.json'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomElavatedButton(
                      text: 'submit',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      fontColor: Colors.black,
                      width: 85.w,
                      height: 7.h,
                      onPress: () {
                        formKey.currentState!.validate();
                        Timestamp timestamp =
                            Timestamp.fromDate(currentDateInDateFormat!);
                        services.updateUserFromProfile(
                          changeNickName.text,
                          changeOccupation.text,
                          timestamp,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectCurrentDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 8)),
      firstDate: DateTime(1950),
      lastDate: DateTime(2017),
    );

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
    setState(() {
      currentDate = formattedDate;
      currentDateInDateFormat = date;
    });
  }

  Future pickImageFromGalllery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(
      () {
        selectedImage = File(returnImage!.path);
        xFile = returnImage;
      },
    );
  }
}
