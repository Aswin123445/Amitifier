import 'dart:io';

import 'package:animated_login/screens/useraccountupdatecode/accountcustomwidget/custom_account_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class UserAccountScreen extends StatefulWidget {
  static const routerName = '/UserAccountScreen';
  final int numberFriends;
  const UserAccountScreen({
    Key? key,
    required this.numberFriends,
  }) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  Map<String, dynamic> data = {};
  FirebaseAuthServices services = FirebaseAuthServices();
  bool nickNamechecker = false;
  bool dobChecker = false;
  bool occupationChecker = false;
  TextEditingController nickNameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  DateTime? initst;
  String? currentDate = 'Select DOB';
  DateTime? currentDateInDateFormat;
  File? selectedImage;
  XFile? xFile;

  void fetchDataToScreen() async {
    data = await services.fetchUserDataToScreen();
    setState(() {
      data;
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
    String url = await services.profilePhoto(xFile!.name, xFile!);
    setState(() {});
    services.addImageToUserData(url);
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      fetchDataToScreen();
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 254, 255),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: .6.h,
              ),
              Container(
                height: 15.5.h,
                width: 100.w,
                margin: EdgeInsets.only(bottom: .4.h),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 151, 4, 174),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        if (selectedImage != null)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(181, 133, 130, 129),
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            child: CircleAvatar(
                              backgroundImage: FileImage(selectedImage!),
                              radius: 39.sp,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        if (data.containsKey('userphotourl') &&
                            selectedImage == null)
                          CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error), //
                            imageUrl: '${data['userphotourl']}',
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 39.sp,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: CircleAvatar(
                                  radius: 39.sp,
                                  backgroundColor: Colors.grey[300],
                                ),
                              );
                            },
                          ),
                        if (!data.containsKey('userphotourl'))
                          CircleAvatar(
                            radius: 40.sp,
                            backgroundColor:
                                const Color.fromARGB(255, 202, 200, 200),
                            backgroundImage:
                                const AssetImage('asset/images/pofile.png'),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15.5.w, 8.3.h, 1.w, .1.h),
                          width: 13.w,
                          height: 4.5.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await pickImageFromGalllery();
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data.isNotEmpty)
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 1.h, left: .2.w),
                            height: 3.6.h,
                            width: 40.w,
                            child: CustomText(
                              text:
                                  '${data['name'][0].toString().toUpperCase()}${data['name'].toString().substring(1).toLowerCase()}',
                              size: 18.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 20.w,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.only(left: 3.w),
                          margin: EdgeInsets.only(left: .4.w),
                          height: 3.3.h,
                          width: 50.w,
                          child: CustomText(
                            text: '${data['email']}',
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                            containerWidth: 28.w,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 1.w),
                          height: 3.h,
                          padding: EdgeInsets.only(left: 3.w),
                          width: 48.w,
                          child: CustomText(
                            text: '${data['PhoneNumber']}',
                            size: 12.sp,
                            fontWeight: FontWeight.bold,
                            containerWidth: 28.w,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                      width: 20.w,
                      child: Lottie.asset('asset/animations/profile.json'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 5.w),
                child: CustomText(
                  text: 'Personal Info',
                  size: 21.sp,
                  fontWeight: FontWeight.bold,
                  containerWidth: 60.w,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.4.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Nick Name :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: 40.w,
                          ),
                        ),
                        if (!data.containsKey('nickName') &&
                            nickNameController.text.isNotEmpty)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 9, 83, 12),
                              text:
                                  '${nickNameController.text.toString()[0].toUpperCase()}${nickNameController.text.toString().substring(1).toLowerCase()}', // '${data['nickName'][0].toString().toUpperCase()}${data['nickName'].toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (data.containsKey('nickName') &&
                            nickNamechecker == false &&
                            nickNameController.text.isEmpty)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text:
                                  '${data['nickName'][0].toString().toUpperCase()}${data['nickName'].toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (data.containsKey('nickName') &&
                            nickNameController.text.isNotEmpty &&
                            nickNamechecker == false)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text:
                                  '${nickNameController.text.toString()[0].toUpperCase()}${nickNameController.text.toString().substring(1).toLowerCase()}', // '${data['nickName'][0].toString().toUpperCase()}${data['nickName'].toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (nickNamechecker == true)
                          Container(
                            padding: EdgeInsets.only(
                              left: 12.w,
                            ),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(),
                              height: 3.5.h,
                              width: 51.w,
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide())),
                                height: 3.h,
                                child: TextField(
                                  autofocus: true,
                                  controller: nickNameController,
                                  decoration: InputDecoration(
                                      hintText: 'Enter new nick name',
                                      hintStyle: TextStyle(fontSize: 11.sp),
                                      contentPadding: EdgeInsets.only(
                                          left: 2.w, bottom: 1.h),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        if (!data.containsKey('nickName') &&
                            nickNamechecker == false)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w, top: 1.h),
                            child: CustomText(
                              text: 'Data Not Found',
                              color: Colors.red,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                      ],
                    ),
                    if (nickNamechecker == false)
                      Container(
                        margin: EdgeInsets.only(left: 14.w, bottom: 3.5.h),
                        height: 4.h,
                        width: 10.w,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                nickNamechecker = true;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    if (nickNamechecker == true)
                      Container(
                        margin: EdgeInsets.only(left: 14.w, bottom: 3.5.h),
                        height: 4.h,
                        width: 10.w,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              nickNamechecker = false;
                            });
                            if (nickNameController.text.isNotEmpty) {
                              services
                                  .updateUserNickName(nickNameController.text);
                            }
                          },
                          icon: const Icon(Icons.done),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.2.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Occupation :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: 40.w,
                          ),
                        ),
                        if (data.containsKey('Occupation') &&
                            occupationChecker == false &&
                            occupationController.text.isEmpty)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text:
                                  '${data['Occupation'][0].toString().toUpperCase()}${data['Occupation'].toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (data.containsKey('Occupation') &&
                            occupationController.text.isNotEmpty &&
                            occupationChecker == false)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text:
                                  '${occupationController.text.toString()[0].toUpperCase()}${occupationController.text.toString().substring(1).toLowerCase()}', // '${data['nickName'][0].toString().toUpperCase()}${data['nickName'].toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (occupationChecker == true)
                          Container(
                            padding: EdgeInsets.only(
                              left: 12.w,
                            ),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(),
                              height: 3.5.h,
                              width: 51.w,
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide())),
                                height: 3.h,
                                child: TextField(
                                  autofocus: true,
                                  controller: occupationController,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Occupation',
                                      hintStyle: TextStyle(fontSize: 11.sp),
                                      contentPadding: EdgeInsets.only(
                                          left: 2.w, bottom: 1.h),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        if (!data.containsKey('Occupation') &&
                            occupationChecker == false)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w, top: 1.h),
                            child: CustomText(
                              text: 'Data Not Found',
                              color: Colors.red,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                      ],
                    ),
                    if (occupationChecker == false)
                      Container(
                        margin: EdgeInsets.only(left: 14.w, bottom: 3.5.h),
                        height: 4.h,
                        width: 10.w,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                occupationChecker = true;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    if (occupationChecker == true)
                      Container(
                        margin: EdgeInsets.only(left: 14.w, bottom: 3.5.h),
                        height: 4.h,
                        width: 10.w,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              occupationChecker = false;
                            });
                            if (occupationController.text.isNotEmpty) {
                              services.udpdateUserOccupation(
                                  occupationController.text);
                            }
                          },
                          icon: const Icon(Icons.done),
                        ),
                      ),
                  ],
                ),
              ),
              //
              SizedBox(
                height: 2.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.2.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Date of Birth :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: dobChecker == false ? 50.w : 59.w,
                          ),
                        ),
                        if (data.containsKey('dob') &&
                            dobChecker == false &&
                            currentDateInDateFormat == null)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w, top: 1.h),
                            child: CustomText(
                              text:
                                  '${DateFormat('dd-MM-yyyy').format(data['dob'].toDate())} ',
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                              color: const Color.fromARGB(255, 8, 175, 13),
                            ),
                          ),
                        if (currentDateInDateFormat != null)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w, top: 1.h),
                            child: CustomText(
                              text: currentDate!,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                        if (!data.containsKey('dob') &&
                            dobChecker == false &&
                            currentDateInDateFormat == null)
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w, top: 1.h),
                            child: CustomText(
                              text: 'Data Not Found',
                              color: Colors.red,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 50.w,
                            ),
                          ),
                      ],
                    ),
                    if (dobChecker == false)
                      Container(
                        margin: EdgeInsets.only(left: 14.w, bottom: 3.5.h),
                        height: 4.h,
                        width: 10.w,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              dobChecker = true;
                            });
                            selectCurrentDate(context);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    if (dobChecker == true)
                      Container(
                        margin: EdgeInsets.only(left: 6.w, bottom: 4.h),
                        height: 5.h,
                        width: 19.w,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                dobChecker = false;
                              });

                              DateTime currentTime = DateTime.now();
                              int age = currentTime.year -
                                  currentDateInDateFormat!.year;
                              services.updateUserdob(
                                Timestamp.fromDate(currentDateInDateFormat!),
                                age,
                              );
                            },
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text: ' Submit?',
                              fontWeight: FontWeight.bold,
                              size: 12.sp,
                              containerWidth: 15.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.6.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Age :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: dobChecker == false ? 50.w : 59.w,
                          ),
                        ),
                        if (data.containsKey('daystobirthday'))
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: const Color.fromARGB(255, 8, 175, 13),
                              text:
                                  '${data['daystobirthday']}, ${NumberToWordsEnglish.convert(data['daystobirthday'])[0].toUpperCase()}${NumberToWordsEnglish.convert(data['daystobirthday']).toString().substring(1).toLowerCase()}',
                              size: 15.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 70.w,
                            ),
                          ),
                        if (!data.containsKey('daystobirthday'))
                          Container(
                            height: 3.4.h,
                            padding: EdgeInsets.only(left: 14.w),
                            child: CustomText(
                              color: Colors.red,
                              text: 'Data Not Found',
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 70.w,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 2.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.2.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Friends :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: 40.w,
                          ),
                        ),
                        Container(
                          height: 3.4.h,
                          padding: EdgeInsets.only(left: 14.w),
                          child: CustomText(
                            color: const Color.fromARGB(255, 8, 175, 13),
                            text: widget.numberFriends > 0
                                ? '${widget.numberFriends}, ${NumberToWordsEnglish.convert(widget.numberFriends)[0].toString().toUpperCase()}${NumberToWordsEnglish.convert(widget.numberFriends).toString().substring(1).toLowerCase()} friends'
                                : 'You have no frriends',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            containerWidth: 50.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomAccountWidget(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 3.2.h,
                          padding: EdgeInsets.only(left: 4.w),
                          child: CustomText(
                            text: 'Personality :',
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 101, 99, 99),
                            containerWidth: 40.w,
                          ),
                        ),
                        Container(
                          height: 4.5.h,
                          padding: EdgeInsets.only(left: 14.w, top: .1.h),
                          child: CustomText(
                            text: widget.numberFriends < 15 &&
                                    widget.numberFriends > 0
                                ? 'Introvert'
                                : widget.numberFriends < 30 &&
                                        widget.numberFriends > 15
                                    ? 'Ambivert'
                                    : widget.numberFriends == 0
                                        ? 'No Friends Yet !'
                                        : 'Extrovert',
                            color: const Color.fromARGB(255, 8, 175, 13),
                            size: 15.sp,
                            fontWeight: FontWeight.bold,
                            containerWidth: 50.w,
                          ),
                        ),
                      ],
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

  Future<void> selectCurrentDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 8)),
      firstDate: DateTime(1950),
      lastDate: DateTime(2017),
    );
    initst = DateTime.now().subtract(const Duration(days: 365 * 5));

    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(date.toString()));
    setState(() {
      currentDate = formattedDate;
      currentDateInDateFormat = date;
    });
  }
}
