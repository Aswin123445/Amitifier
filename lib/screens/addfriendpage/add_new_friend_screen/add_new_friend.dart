import 'dart:io';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/screens/addfriendpage/add_new_friend_screen/add_new_friend_two.dart';
import 'package:animated_login/screens/addfriendpage/custom_widget/custom_add_friend_heading.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_event_info.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_inkwell_widget.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AddNewFriend extends StatefulWidget {
  static const String routerName = '/addnewfriend';

  const AddNewFriend({super.key});

  @override
  State<AddNewFriend> createState() => _AddNewFriendState();
}

class _AddNewFriendState extends State<AddNewFriend> {
  final TextEditingController nameController = TextEditingController();
  DateTime? currentDateInDateFormat;
  final FirebaseAuthServices services = FirebaseAuthServices();
  String? currentDate = 'Select DOB';
  File? selectedImage;
  XFile? xFile;
  XFile? xxfile;
  bool? isMile;
  final formKey = GlobalKey<FormState>();
  DateTime? initst;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const CustomAddFriendContainer(),
              SizedBox(
                height: 7.h,
              ),
              Stack(
                children: [
                  if (selectedImage == null && isMile == null)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(181, 133, 130, 129),
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                      child: CircleAvatar(
                        radius: 35.sp,
                        backgroundColor:
                            const Color.fromARGB(255, 222, 221, 221),
                      ),
                    ),
                  if (selectedImage == null)
                    if (isMile == true)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(181, 133, 130, 129),
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: CircleAvatar(
                          backgroundImage: const AssetImage(
                            'asset/images/accountmale.png',
                          ),
                          radius: 35.sp,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                  if (selectedImage == null)
                    if (isMile == false)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(181, 133, 130, 129),
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: CircleAvatar(
                          backgroundImage: const AssetImage(
                            'asset/images/female_acc.png',
                          ),
                          radius: 35.sp,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                  if (selectedImage != null)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(181, 133, 130, 129),
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                      child: CircleAvatar(
                        backgroundImage: FileImage(selectedImage!),
                        radius: 35.sp,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(left: 15.w, top: 7.h),
                    height: 5.h,
                    width: 10.w,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 240, 240),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        pickImageFromGalllery();
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 25.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 11.w),
                child: Center(
                  child: CustomText(
                    text: 'Photo',
                    containerWidth: 25.w,
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMile = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: CustomEventInfo(
                        width: 40.w,
                        height: 8.h,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          color: isMile == true
                              ? const Color.fromARGB(195, 204, 233, 242)
                              : const Color.fromARGB(255, 253, 248, 247),
                          width: 5.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: 'MALE',
                                containerWidth: 15.w,
                                size: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 72, 72, 70),
                              ),
                              Lottie.asset('asset/animations/male.json'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMile = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: CustomEventInfo(
                          width: 40.w,
                          height: 8.h,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            color: isMile == false
                                ? const Color.fromARGB(195, 204, 233, 242)
                                : const Color.fromARGB(255, 255, 255, 255),
                            width: 5.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'FEMALE',
                                  containerWidth: 18.w,
                                  size: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 72, 72, 70),
                                ),
                                SizedBox(
                                  width: 21.3.w,
                                  child: Lottie.asset(
                                    'asset/animations/female.json',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 9.w,
                ),
                child: CustomTextFormField(
                  controller: nameController,
                  obscureText: false,
                  color: Colors.white,
                  textInputAction: TextInputAction.done,
                  hintText: 'name of friend',
                  contentPadding: EdgeInsets.only(left: 3.w),
                  validator: (p0) {
                    if (p0 == null) {
                      return 'not be empty';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                width: 82.w,
                child: GestureDetector(
                  onTap: () => selectCurrentDate(context),
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
                            child: Lottie.asset('asset/animations/dob.json'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomInkwellButton(
                text: 'Next',
                containerWidth: 19.w,
                ontap: () async {
                  if (isMile == true) {
                    await trigerrfiletoxfile("asset/images/accountmale.png");
                  }
                  if (isMile == false) {
                    await trigerrfiletoxfile("asset/images/female_acc.png");
                  }

                  navigateToAddNewFriendTwo();
                },
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
    initst = DateTime.now().subtract(const Duration(days: 365 * 5));

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
    setState(() {
      currentDate = formattedDate;
      currentDateInDateFormat = date;
    });
  }

  Future<void> trigerrfiletoxfile(String link) async {
    xxfile = await services.assetToXFile(link);
    setState(() {});
  }

  void navigateToAddNewFriendTwo() {
    if (currentDateInDateFormat != null) {
      if (formKey.currentState!.validate()) {
        if (isMile == false || isMile == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNewFriendTwo(
                  image: xFile ?? xxfile!,
                  nameController: nameController,
                  date: currentDateInDateFormat!,
                  isMale: isMile!,
                );
              },
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All field must filled'),
        ),
      );
    }
  }
}
