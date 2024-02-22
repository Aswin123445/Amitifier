import 'dart:io';

import 'package:animated_login/screens/update_friend_page/friend_photosl.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';

class FriendDetails extends StatefulWidget {
  static const routerName = '/frienddetails';
  final Map<String, dynamic> friendData;
  final int age;
  final int daysOfBirthday;
  const FriendDetails({
    Key? key,
    required this.friendData,
    required this.age,
    required this.daysOfBirthday,
  }) : super(key: key);

  @override
  State<FriendDetails> createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  File? selectedImage;
  XFile? xFile;

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

  TextEditingController desController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  final nickNameGlobalKey = GlobalKey<FormState>();
  bool nameChecker = false;
  bool nickNameChecker = false;

  final FirebaseAuthServices services = FirebaseAuthServices();
  bool descriptionChecker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 254, 255),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: .5.h,
              ),
              Container(
                height: 13.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.sp),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      height: 13.h,
                      width: 28.w,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          if (selectedImage == null)
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 39.sp,
                                  child: Icon(
                                    Icons.error,
                                    size: 34.sp,
                                  ),
                                ), //
                                imageUrl:
                                    '${widget.friendData['friendprofileurl']}',
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
                            ),
                          if (selectedImage != null)
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: CircleAvatar(
                                radius: 40.sp,
                                backgroundImage: FileImage(selectedImage!),
                              ),
                            ),
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(17.5.w, 8.3.h, 1.w, .1.h),
                            width: 13.w,
                            height: 4.5.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                await pickImageFromGalllery();
                                final url = await services
                                    .ubdatingFriendProfile(xFile!.name, xFile!);
                                await services.updateFriendProfilePhoto(
                                  url,
                                  widget.friendData['uniqeno'],
                                );
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 1.4.h),
                          height: 6.h,
                          width: 50.w,
                          child: Row(
                            children: [
                              if ((nameChecker == false) &&
                                  nameController.text.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: CustomText(
                                    containerWidth: 33.w,
                                    text:
                                        '${nameController.text.toString()[0].toUpperCase()}${nameController.text.toString().substring(1).toLowerCase()}', //'${widget.friendData['name'][0].toString().toUpperCase()}${widget.friendData['name'].toString().substring(1).toLowerCase()}',
                                    size: 21.sp,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              if ((nameChecker == false) &&
                                  nameController.text.isEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: CustomText(
                                    containerWidth: 33.w,
                                    text:
                                        '${widget.friendData['name'][0].toString().toUpperCase()}${widget.friendData['name'].toString().substring(1).toLowerCase()}',
                                    size: 21.sp,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              if (nameChecker == true)
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: 38.3.w,
                                  child: Form(
                                    child: Container(
                                      height: 4.h,
                                      alignment: Alignment.bottomLeft,
                                      padding: EdgeInsets.only(left: .2.w),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 1.w, bottom: .6.h),
                                          hintText: 'Enter new Name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (nameChecker == true)
                                Container(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        nameChecker = false;
                                      });
                                      if (nameController.text.isEmpty) {
                                        nameChecker = false;
                                        setState(() {});
                                      }
                                      if (nameController.text.isNotEmpty) {
                                        await services.updateFriendName(
                                            widget.friendData['uniqeno'],
                                            nameController.text);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.done,
                                      size: 16.sp,
                                      color: const Color.fromARGB(
                                          255, 174, 8, 200),
                                    ),
                                  ),
                                ),
                              if (nameChecker == false)
                                Container(
                                  padding: EdgeInsets.only(left: 1.w),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        nameChecker = true;
                                      });
                                    },
                                    icon: Container(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: Icon(
                                        Icons.edit,
                                        size: 16.sp,
                                        color: const Color.fromARGB(
                                            255, 174, 8, 200),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: 5.h,
                          width: 43.w,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: CustomText(
                              containerWidth: 40.w,
                              text:
                                  'dob : ${DateFormat('dd-MM-yyyy').format(widget.friendData['dob'].toDate())}',
                              size: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 90, 90, 90),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                      width: 20.w,
                      child: Lottie.asset('asset/animations/profile.json'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: .4.h,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 45.h,
                width: 97.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(193, 212, 196, 255),
                  border: Border.all(
                    color: const Color.fromARGB(255, 85, 82, 85),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.sp),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 3.w,
                      ),
                      height: 7.4.h,
                      width: 74.w,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Color.fromARGB(255, 233, 224, 224))
                        ],
                        color: const Color.fromARGB(220, 248, 252, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 213, 6, 182),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              if (nickNameChecker == false)
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: CustomText(
                                    text: 'Nick Name :',
                                    size: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    containderHeight: 3.h,
                                    color: Colors.grey,
                                    containerWidth: 32.w,
                                  ),
                                ),
                              if (nickNameChecker == false)
                                if (nickNameController.text.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: CustomText(
                                      text: nickNameController
                                          .text, //'${widget.friendData['nickName'][0].toString().toUpperCase()}${widget.friendData['nickName'].toString().substring(1).toLowerCase()}',
                                      size: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      containerWidth: 32.w,
                                      containderHeight: 3.5.h,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              if (nickNameChecker == false)
                                if (nickNameController.text.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: CustomText(
                                      text:
                                          '${widget.friendData['nickName'][0].toString().toUpperCase()}${widget.friendData['nickName'].toString().substring(1).toLowerCase()}',
                                      size: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      containerWidth: 32.w,
                                      containderHeight: 3.5.h,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              if (nickNameChecker == true)
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: 49.3.w,
                                  child: Form(
                                    child: Container(
                                      height: 4.h,
                                      alignment: Alignment.bottomLeft,
                                      padding: EdgeInsets.only(left: .2.w),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: nickNameController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 7.w, bottom: .6.h),
                                          hintText: 'Enter new nick name',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (nickNameChecker == false)
                            SizedBox(
                              width: 24.w,
                            ),
                          if (nickNameChecker == true)
                            SizedBox(
                              width: 15.w,
                            ),
                          if (nickNameChecker == false)
                            Container(
                              padding: EdgeInsets.only(bottom: 2.h, right: 1.w),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    nickNameChecker = true;
                                  });
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20.sp,
                                  color: const Color.fromARGB(255, 174, 8, 200),
                                ),
                              ),
                            ),
                          if (nickNameChecker == true)
                            Container(
                              padding: EdgeInsets.only(bottom: 2.h, right: 1.w),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    nickNameChecker = false;
                                  });
                                  if (nickNameController.text.isEmpty) {
                                    nickNameChecker = false;
                                    setState(() {});
                                  }
                                  if (nickNameController.text.isNotEmpty) {
                                    await services.updateFriendNickName(
                                        widget.friendData['uniqeno'],
                                        nickNameController.text);
                                  }
                                },
                                child: Icon(
                                  Icons.done,
                                  size: 20.sp,
                                  color: const Color.fromARGB(255, 174, 8, 200),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 3.w,
                      ),
                      height: 7.4.h,
                      width: 74.w,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Color.fromARGB(255, 233, 224, 224))
                        ],
                        color: const Color.fromARGB(220, 248, 252, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 213, 6, 182),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 6.w),
                                child: CustomText(
                                  text: 'Age :',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  containderHeight: 3.h,
                                  color: Colors.grey,
                                  containerWidth: 32.w,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: CustomText(
                                  text:
                                      '${widget.age.toString()},  ${NumberToWordsEnglish.convert(widget.age).toString()[0].toUpperCase()}${NumberToWordsEnglish.convert(widget.age).toString().substring(1).toLowerCase()}',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  containerWidth: 32.w,
                                  containderHeight: 3.5.h,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 3.w,
                      ),
                      height: 7.4.h,
                      width: 74.w,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Color.fromARGB(255, 233, 224, 224))
                        ],
                        color: const Color.fromARGB(220, 248, 252, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 213, 6, 182),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 6.w),
                                child: CustomText(
                                  text: 'Gender :',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  containderHeight: 3.h,
                                  color: Colors.grey,
                                  containerWidth: 32.w,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: CustomText(
                                  text: widget.friendData['male'] == true
                                      ? 'Male'
                                      : 'Female',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  containerWidth: 32.w,
                                  containderHeight: 3.5.h,
                                  overflow: TextOverflow.ellipsis,
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
                    Container(
                      margin: EdgeInsets.only(
                        left: 3.w,
                      ),
                      height: 7.4.h,
                      width: 74.w,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Color.fromARGB(255, 233, 224, 224))
                        ],
                        color: const Color.fromARGB(220, 248, 252, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 213, 6, 182),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 6.w),
                                child: CustomText(
                                  text: 'Days To Birthday :',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  containderHeight: 3.h,
                                  color: Colors.grey,
                                  containerWidth: 43.w,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: CustomText(
                                  text: widget.daysOfBirthday == 365
                                      ? 'Today'
                                      : widget.daysOfBirthday == 0
                                          ? 'tomorrow'
                                          : '${widget.daysOfBirthday} Days, ',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  containerWidth: 34.w,
                                  containderHeight: 3.5.h,
                                  overflow: TextOverflow.ellipsis,
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
              SizedBox(
                height: .5.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: CustomText(
                      text: 'About ',
                      size: 20.sp,
                      fontWeight: FontWeight.bold,
                      containerWidth: 25.w,
                    ),
                  ),
                  CustomText(
                    text: widget.friendData['name'][0].toString().toUpperCase(),
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 6.5.w,
                  ),
                  CustomText(
                    containerWidth: 4.5.w,
                    text: widget.friendData['name'][1].toString().toLowerCase(),
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 153, 2, 156),
                  ),
                  CustomText(
                    containerWidth: 14.w,
                    text: widget.friendData['name'].toString().substring(2),
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: '!',
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 153, 2, 156),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  if (descriptionChecker == false)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          descriptionChecker = true;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        size: 25.sp,
                        color: Colors.blue,
                      ),
                    ),
                  if (descriptionChecker == true)
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          descriptionChecker = false;
                        });
                        await services.appendFriendDesWithNewData(
                            widget.friendData['uniqeno'], desController.text);
                      },
                      icon: Icon(
                        Icons.done,
                        size: 25.sp,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
              if (descriptionChecker == false)
                Container(
                  padding: EdgeInsets.only(
                      top: .4.h, left: 2.w, right: 1.w, bottom: .5.h),
                  margin: EdgeInsets.only(top: 1.h),
                  height: 20.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(193, 212, 196, 255),
                    borderRadius: BorderRadius.circular(14.sp),
                    border: Border.all(
                      color: const Color.fromARGB(231, 168, 3, 165),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.friendData['description'].length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(3.w, 2.8.h, 3.w, 1.h),
                            margin: EdgeInsets.only(
                                left: 2.w, top: .5.h, right: 2.w, bottom: 1.h),
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                            height: 17.h,
                            child: SingleChildScrollView(
                              child: CustomText(
                                text:
                                    '${widget.friendData['description'][index]}',
                                size: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            margin: EdgeInsets.only(right: 3.w, top: .8.h),
                            height: 3.2.h,
                            width: 10.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  services.deleteFriendDescription(
                                      widget.friendData['uniqeno'], index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(' Deleted succesfull'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              if (descriptionChecker == true)
                Container(
                  padding: EdgeInsets.only(
                      top: 2.h, left: 2.w, right: 1.w, bottom: 0),
                  margin: EdgeInsets.only(top: .51.h),
                  height: 20.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(111, 241, 214, 214),
                    borderRadius: BorderRadius.circular(14.sp),
                    border: Border.all(
                      color: const Color.fromARGB(231, 168, 3, 165),
                    ),
                  ),
                  child: TextFormField(
                    maxLines: null,
                    controller: desController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(left: 10.w, bottom: 1.3.h),
                      hintText: 'tell us about ${widget.friendData['name']}',
                    ),
                  ),
                ),
              Container(
                height: 8.h,
                margin: EdgeInsets.only(bottom: 1.h),
                padding: EdgeInsets.only(top: 1.h),
                child: Center(
                  child: TextButton(
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(178, 221, 93, 221),
                      ),
                    ),
                    onPressed: () {
                      navigateToFriendPhoto(widget.friendData);
                    },
                    child: CustomText(
                      text: '    See Memories',
                      containerWidth: 50.w,
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToFriendPhoto(Map<String, dynamic> data) {
    Navigator.pushNamed(context, FriendPhots.routerName, arguments: data);
  }
}
