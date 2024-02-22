// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/update_friend_page/friend_photo_add.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class FriendPhots extends StatefulWidget {
  static const routerName = '/friendPhotos';
  final Map<String, dynamic> photosLink;

  const FriendPhots({
    Key? key,
    required this.photosLink,
  }) : super(key: key);

  @override
  State<FriendPhots> createState() => _FriendPhotsState();
}

class _FriendPhotsState extends State<FriendPhots> {
  final ScrollController _scrollController = ScrollController();
  FirebaseAuthServices services = FirebaseAuthServices();
  int currentIndex = 0;
  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentIndex < widget.photosLink['friendphotos'].length - 1) {
        currentIndex++;
        _scrollController.animateTo(
          currentIndex * 100.0, // Adjust the item height as needed
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel(); // Stop auto-scrolling when reaching the end
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.white,
                  width: 55.w,
                  height: 14.h,
                  margin: EdgeInsets.only(left: 7.w, top: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Pause l',
                            containerWidth: 29.6.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: 'i',
                            size: 24.sp,
                            containerWidth: 2.w,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 181, 0, 153),
                          ),
                          CustomText(
                            text: 'fe',
                            size: 24.sp,
                            containerWidth: 9.w,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: '!',
                            containerWidth: 2.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 181, 0, 153),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'On Am',
                            containerWidth: 28.9.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: 'i',
                            containerWidth: 2.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 181, 0, 153),
                          ),
                          CustomText(
                            text: 't',
                            containerWidth: 3.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: 'i',
                            size: 24.sp,
                            containerWidth: 2.w,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 181, 0, 153),
                          ),
                          CustomText(
                            text: 'f',
                            containerWidth: 3.w,
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: 'i',
                            size: 24.sp,
                            containerWidth: 2.w,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 181, 0, 153),
                          ),
                          CustomText(
                            text: 'er',
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 3.w,
                  ),
                  height: 20.h,
                  width: 30.w,
                  child: Lottie.asset('asset/animations/friends.json'),
                ),
              ],
            ),
            Container(
              width: 90.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.sp))),
              height: 60.h,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.photosLink['friendphotos'].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Stack(
                        children: [
                          CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error), //
                            imageUrl:
                                '${widget.photosLink['friendphotos'][index]}',
                            imageBuilder: (context, imageProvider) => Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.sp),
                                ),
                              ),
                              height: 55.h,
                              width: 80.w,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),

                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 175, 174, 174),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.sp),
                                      ),
                                    ),
                                    height: 55.h,
                                    width: 80.w,
                                  ));
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 64.w),
                            child: IconButton(
                              onPressed: () {
                                services.deleteFriendPhotolink(
                                    widget.photosLink['uniqeno'], index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: (Text('deleted successfully')),
                                  ),
                                );
                              },
                              icon: const CircleAvatar(
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(178, 221, 93, 221),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return FriendPhotoAdd(
                        docid: widget.photosLink['uniqeno'].toString(),
                      );
                    },
                  );
                },
                child: CustomText(
                  containerWidth: 36.w,
                  text: '  Add More',
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
