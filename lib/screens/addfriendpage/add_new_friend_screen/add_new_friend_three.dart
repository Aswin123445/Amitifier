// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/cutom_elevated_button.dart';
import 'package:animated_login/screens/addfriendpage/custom_widget/custom_add_friend_heading.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddNewFriendThree extends StatefulWidget {
  final String name;
  final bool ismaile;
  final DateTime date;
  final XFile imagefriend;
  final String nickName;
  final List<String> firenddescription;
  const AddNewFriendThree({
    Key? key,
    required this.name,
    required this.ismaile,
    required this.date,
    required this.imagefriend,
    required this.nickName,
    required this.firenddescription,
  }) : super(key: key);

  @override
  State<AddNewFriendThree> createState() => _AddNewFriendThreeState();
}

class _AddNewFriendThreeState extends State<AddNewFriendThree> {
  List<String> urllist = [];
  String? url;
  bool roundRoller = false;
  final FirebaseAuthServices firebase = FirebaseAuthServices();
  List<XFile>? images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAddFriendContainer(),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 8.w, top: 2.h),
              child: CustomText(
                text: 'Share memories',
                size: 19.sp,
                containerWidth: 80.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 7.5.w,
                ),
                CustomText(
                  text: 'Of',
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                  containerWidth: 10.w,
                ),
                Container(
                  width: 50.w,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: .1.w, top: .3.h),
                  child: CustomText(
                    containerWidth: 31.h,
                    text:
                        '${widget.name[0].toUpperCase() + widget.name.substring(1).toLowerCase()} !',
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 194, 2, 223),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            if (images == null)
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 223, 4, 190)),
                ),
                height: 30.h,
                width: 85.w,
                child: Center(
                    child: IconButton(
                  onPressed: () {
                    multipleImages();
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 60.sp,
                  ),
                )),
              ),
            if (images != null)
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 223, 4, 190)),
                    borderRadius: BorderRadius.circular(10.sp)),
                height: 30.h,
                width: 85.w,
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.all(5.sp),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        width: 70.w,
                        height: 10.h,
                        child: Image.file(
                          File(images![index].path),
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    }),
              ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: 5.w),
              child: InkWell(
                onTap: multipleImages,
                child: CustomText(
                  containerWidth: 22.w,
                  text: 'Change ?',
                  size: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 40, 167, 1),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            if (roundRoller == true)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElavatedButton(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                    width: 100.w,
                    height: 5.h,
                    onPress: () async {},
                    child: const CircularProgressIndicator()),
              ),
            if (roundRoller == false)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomElavatedButton(
                  text: 'Submit',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontColor: Colors.black,
                  width: 100.w,
                  height: 7.h,
                  onPress: () async {
                    DateTime currentDate = DateTime.now();
                    bool isBirthdayPassedThisYear =
                        currentDate.month > widget.date.month ||
                            (currentDate.month == widget.date.month &&
                                currentDate.day >= widget.date.day);
                    int nextBirthdayYear = isBirthdayPassedThisYear
                        ? currentDate.year + 1
                        : currentDate.year;
                    DateTime nextBirthday = DateTime(
                        nextBirthdayYear, widget.date.month, widget.date.day);
                    int daysUntilBirthday =
                        nextBirthday.difference(currentDate).inDays;
                    setState(() {
                      roundRoller = true;
                    });
                    String url1;
                    if (images != null) {
                      for (int i = 0; i < images!.length; i++) {
                        url1 = await firebase.friendsPhotos(
                            images![i].name, images![i]);
                        urllist.add(url1);
                      }
                      url = await firebase.friendProfilePhoto(
                          widget.imagefriend.name, widget.imagefriend);
                      firebase.setfriendsDat(
                        daysUntilBirthday,
                        Timestamp.fromDate(nextBirthday),
                        widget.nickName,
                        widget.name,
                        widget.firenddescription,
                        widget.ismaile,
                        Timestamp.fromDate(widget.date),
                        url!,
                        urllist,
                      );
                    }
                    if (images == null) {
                      url = await firebase.friendProfilePhoto(
                          widget.imagefriend.name, widget.imagefriend);
                      firebase.setfriendsDat(
                        daysUntilBirthday,
                        Timestamp.fromDate(nextBirthday),
                        widget.nickName,
                        widget.name,
                        widget.firenddescription,
                        widget.ismaile,
                        Timestamp.fromDate(widget.date),
                        url!,
                        urllist,
                      );
                    }
                    setState(() {
                      roundRoller = false;
                    });

                    //ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Succefull'),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ), (route) => false);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<List<XFile>> multipleImages() async {
    images = await ImagePicker().pickMultiImage();
    setState(() {});
    return images!;
  }

  void navigateToHomePage() {
    Navigator.pushNamed(
      context,
      HomeScreen.routerName,
    );
  }
}
