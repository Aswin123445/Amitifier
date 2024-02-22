// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class FriendPhotoAdd extends StatefulWidget {
  final String docid;
  const FriendPhotoAdd({
    Key? key,
    required this.docid,
  }) : super(key: key);

  @override
  State<FriendPhotoAdd> createState() => _FriendPhotoAddState();
}

class _FriendPhotoAddState extends State<FriendPhotoAdd> {
  final FirebaseAuthServices firebase = FirebaseAuthServices();
  final _scrollController = ScrollController();
  bool roundIndicatot = false;
  List<String> url = [];
  List<XFile>? images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.sp),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              Container(
                padding: EdgeInsets.only(top: 3.h, left: 5.w, bottom: 2.h),
                child: CustomText(
                  text: 'Add Images',
                  containerWidth: 50.w,
                  size: 23.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              Container(
                  padding: EdgeInsets.only(top: 2.h),
                  height: 13.h,
                  child: Lottie.asset('asset/animations/friends.json'))
            ],
          ),
          if (images!.isEmpty)
            GestureDetector(
              onTap: () async {
                await multipleImages();
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(top: 2.h),
                height: 30.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(165, 194, 192, 192),
                  border: Border.all(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.sp),
                  ),
                ),
                child: Center(
                  child: CustomText(
                    text: '     CLICK HERE !',
                    containerWidth: 60.w,
                    size: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 114, 113, 114),
                  ),
                ),
              ),
            ),
          if (images!.isNotEmpty)
            Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.only(top: 2.h),
                  height: 30.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (context, index) {
                      if (images!.isEmpty) {
                        return Center(
                          child: CustomText(
                            fontWeight: FontWeight.bold,
                            text: 'add images',
                            size: 15.sp,
                          ),
                        );
                      }
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.sp))),
                        width: 60.w,
                        height: 25.h,
                        child: Image.file(
                          File(images![index].path),
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    multipleImages();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10.w),
                    alignment: Alignment.bottomRight,
                    child: CustomText(
                      text: 'Update??',
                      containerWidth: 22.w,
                      size: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 160, 0, 166),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  height: 6.h,
                  child: TextButton(
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(178, 221, 93, 221),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        roundIndicatot = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Photos Updated succefully'),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Timer(const Duration(seconds: 3), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      });

                      String url1;
                      if (images != null) {
                        for (int i = 0; i < images!.length; i++) {
                          url1 = await firebase.friendsPhotos(
                              images![i].name, images![i]);
                          url.add(url1);
                        }
                        await firebase.updateFriendPhotosLink(
                            widget.docid, url);
                        setState(() {
                          roundIndicatot = false;
                        });
                      }
                      // ignore: use_build_context_synchronously

                      // ignore: use_build_context_synchronously
                    },
                    child: roundIndicatot == true
                        ? const CircularProgressIndicator()
                        : CustomText(
                            text: '   Submit',
                            containerWidth: 30.w,
                            size: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> multipleImages() async {
    List<XFile>? selectImage = await ImagePicker().pickMultiImage();
    if (selectImage.isNotEmpty || images!.isNotEmpty) {
      images!.addAll(selectImage);
    }
    // if (selectImage.isNotEmpty || images!.isEmpty) {
    //   images = selectImage;
    // }
    setState(() {});
  }

  Future<void> scrollToBottom() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
