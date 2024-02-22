// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class CustomDetailsWid extends StatefulWidget {
  final String? lottieLink;
  final bool isEdit;
  final double? editButtonpadding;
  final String id;
  final String head;
  final String value;
  const CustomDetailsWid({
    Key? key,
    this.lottieLink,
    required this.isEdit,
    this.editButtonpadding,
    required this.id,
    required this.head,
    required this.value,
  }) : super(key: key);

  @override
  State<CustomDetailsWid> createState() => _CustomDetailsWidgetState();
}

class _CustomDetailsWidgetState extends State<CustomDetailsWid> {
  final FirebaseAuthServices services = FirebaseAuthServices();
  TextEditingController nickNameController = TextEditingController();
  bool nickNameChecker = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 5.w),
      height: 10.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: widget.head,
                size: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 87, 85, 85),
              ),
              if (nickNameChecker == false && widget.isEdit == true)
                Container(
                  padding:
                      EdgeInsets.only(left: widget.editButtonpadding ?? 35.w),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        nickNameChecker = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 20.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              if (nickNameChecker == false && widget.isEdit == false)
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: widget.editButtonpadding ?? 30.w),
                  child: Lottie.asset(widget.lottieLink!, height: 5.h),
                ),
              if (nickNameChecker == true)
                Container(
                  padding: EdgeInsets.only(left: 35.w),
                  child: IconButton(
                    onPressed: () async {
                      if (nickNameController.text.isEmpty) {
                        setState(() {
                          nickNameChecker = false;
                        });
                      }
                      if (nickNameController.text.isNotEmpty) {
                        await services.updateFriendNickName(
                          widget.id,
                          nickNameController.text,
                        );
                      }

                      setState(() {
                        nickNameController.clear();
                        nickNameChecker = false;
                      });
                    },
                    icon: Icon(
                      Icons.done,
                      size: 20.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
          if (nickNameChecker == false)
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 5.w),
              child: CustomText(
                text: widget.value,
                // '${widget.friendData['nickName'][0].toString().toUpperCase()}${widget.friendData['nickName'].toString().substring(1).toLowerCase()}',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 164, 0, 161),
              ),
            ),
          if (nickNameChecker == true)
            Form(
              child: Container(
                height: 4.h,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 1.h),
                child: TextFormField(
                  autofocus: true,
                  controller: nickNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10.w, bottom: 1.3.h),
                    hintText: 'Enter new Nick Name',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
