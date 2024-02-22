// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_login/screens/addfriendpage/add_new_friend_screen/add_new_friend_three.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/screens/addfriendpage/custom_widget/custom_add_friend_heading.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_event_info.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_inkwell_widget.dart';

class AddNewFriendTwo extends StatefulWidget {
  static const String router = '/add-new-friend2';
  final TextEditingController nameController;
  final bool isMale;
  final DateTime date;
  final XFile image;
  const AddNewFriendTwo({
    Key? key,
    required this.nameController,
    required this.isMale,
    required this.date,
    required this.image,
  }) : super(key: key);

  @override
  State<AddNewFriendTwo> createState() => _AddNewFriendTwoState();
}

class _AddNewFriendTwoState extends State<AddNewFriendTwo> {
  TextEditingController nickController = TextEditingController();
  TextEditingController desController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CustomAddFriendContainer(),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.w,
                  ),
                  child: CustomTextFormField(
                    controller: nickController,
                    obscureText: false,
                    color: Colors.white,
                    textInputAction: TextInputAction.done,
                    hintText: 'nick name of friend',
                    contentPadding: EdgeInsets.only(left: 3.w),
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'must type nick name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 9.w),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    containerWidth: 60.w,
                    text: 'Tell us about',
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 9.w),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    containerWidth: 65.w,
                    text: 'Your friend',
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SingleChildScrollView(
                  child: CustomEventInfo(
                    width: 80.w,
                    child: TextFormField(
                      controller: desController,
                      maxLines: null,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must type something';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 17.sp),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(3.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomInkwellButton(
                  containerWidth: 20.w,
                  text: 'Next',
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      final List<String> description = [];
                      description.insert(0, desController.text);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AddNewFriendThree(
                              name: widget.nameController.text,
                              ismaile: widget.isMale,
                              date: widget.date,
                              imagefriend: widget.image,
                              nickName: nickController.text,
                              firenddescription: description,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
