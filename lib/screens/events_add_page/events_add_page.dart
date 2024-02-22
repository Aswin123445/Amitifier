import 'dart:async';

import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/globalcustomwidgets/custom_textfield.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_event_info.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_inkwell_widget.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class EventsAddPage extends StatefulWidget {
  static const routerName = 'EvetentsaddPage';
  const EventsAddPage({super.key});

  @override
  State<EventsAddPage> createState() => _EventsAddPageState();
}

class _EventsAddPageState extends State<EventsAddPage> {
  String mode = 'Birthday Party';

  void setMode(String newValue) {
    if (newValue == 'option1') {
      setState(() {
        mode = 'Birthday Party';
      });
    } else if (newValue == 'option2') {
      setState(() {
        mode = 'Marriage';
      });
    } else if (newValue == 'option3') {
      setState(() {
        mode = 'Get together';
      });
    } else if (newValue == 'option4') {
      setState(() {
        mode = 'Tour';
      });
    } else {
      setState(() {
        mode = 'Otheres';
      });
    }
  }

  String selectedValue = 'option1';
  List<DropdownMenuItem<String>> dropDownMenuItems = [
    DropdownMenuItem(
      value: 'option1',
      child: Text(
        'Birthday Party',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'option2',
      child: Text(
        'Marriage',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DropdownMenuItem(
        value: 'option3',
        child: Text(
          'Get together',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        )),
    DropdownMenuItem(
        value: 'option4',
        child: Text(
          'Tour',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        )),
    DropdownMenuItem(
        value: 'option5',
        child: Text(
          'Otheres',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        )),
  ];
  bool roundIndicator = false;
  String? currentDate;
  DateTime? currentDateInDateFormat;
  DateTime? initst;
  final formKey = GlobalKey<FormState>();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController rememberController = TextEditingController();
  final FirebaseAuthServices services = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            children: [
                              CustomText(
                                text: 'D',
                                size: 24.sp,
                                containerWidth: 6.3.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'o',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 'n',
                                size: 24.sp,
                                containerWidth: 5.2.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: '\'',
                                size: 24.sp,
                                containerWidth: 2.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 't',
                                size: 24.sp,
                                containerWidth: 2.7.w,
                                fontWeight: FontWeight.bold,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: CustomText(
                                  text: 'm',
                                  size: 24.sp,
                                  containerWidth: 7.8.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CustomText(
                                text: 'i',
                                size: 24.sp,
                                containerWidth: 2.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 'ss',
                                size: 24.sp,
                                containerWidth: 8.8.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Anything t',
                                size: 24.sp,
                                containerWidth: 42.9.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'o',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            children: [
                              CustomText(
                                text: 'C',
                                size: 24.sp,
                                containerWidth: 6.8.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'e',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 'l',
                                size: 24.sp,
                                containerWidth: 2.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'e',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 'bra',
                                size: 24.sp,
                                containerWidth: 14.w,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 't',
                                size: 24.sp,
                                containerWidth: 3.2.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: 'e',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 181, 0, 153),
                              ),
                              CustomText(
                                text: '!',
                                size: 24.sp,
                                containerWidth: 5.w,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.w, top: .5.h),
                      height: 16.h,
                      width: 46.w,
                      child: Lottie.asset('asset/animations/eventscover.json'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 6.w),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: 'Mode of Event',
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 70.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  height: 5.5.h,
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
                        spreadRadius: 1,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 7.w,
                      ),
                      DropdownButton<String>(
                        items: dropDownMenuItems,
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            setMode(newValue);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 6.w),
                //   alignment: Alignment.bottomLeft,
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 20.w,
                //       ),
                //       DropdownButton<String>(
                //         items: dropDownMenuItems,
                //         value: selectedValue,
                //         onChanged: (newValue) {
                //           setState(() {
                //             selectedValue = newValue!;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(left: 6.w),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: 'Event  Name',
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 50.w,
                  ),
                ),
                SizedBox(
                  height: .6.h,
                ),
                SizedBox(
                  height: 5.5.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: CustomTextFormField(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Must not empty';
                        }
                        return null;
                      },
                      controller: eventNameController,
                      obscureText: false,
                      color: Colors.white,
                      textInputAction: TextInputAction.next,
                      contentPadding: EdgeInsets.only(left: 5.w),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6.w, top: 2.h),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: 'Location',
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 50.w,
                  ),
                ),
                SizedBox(
                  height: .6.h,
                ),
                SizedBox(
                  height: 5.5.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: CustomTextFormField(
                      controller: locationController,
                      obscureText: false,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Must not empty';
                        }
                        return null;
                      },
                      color: Colors.white,
                      textInputAction: TextInputAction.next,
                      contentPadding: EdgeInsets.only(left: 5.w),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6.w, top: 2.h),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: 'Date',
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 50.w,
                  ),
                ),
                SizedBox(
                  height: .6.h,
                ),
                GestureDetector(
                  onTap: () {
                    selectCurrentDate(context);
                  },
                  child: CustomEventInfo(
                    width: 85.w,
                    height: 6.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 3.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.4.h),
                          child: CustomText(
                            text: currentDate ?? 'Select Date !',
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                            containerWidth: 40.w,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Lottie.asset('asset/animations/dob.json')
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6.w, top: 2.h),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: 'To Remeber',
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                    containerWidth: 50.w,
                  ),
                ),
                SizedBox(
                  height: .6.h,
                ),
                SingleChildScrollView(
                  child: CustomEventInfo(
                    height: 20.h,
                    width: 85.w,
                    child: TextFormField(
                      controller: rememberController,
                      maxLines: null,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must type something';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText:
                            'type something should \nremember that day...',
                        errorStyle: TextStyle(fontSize: 17.sp),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(3.sp),
                      ),
                    ),
                  ),
                ),
                if (roundIndicator == true) const CircularProgressIndicator(),
                if (roundIndicator == false)
                  CustomInkwellButton(
                    text: 'Schedule',
                    ontap: () {
                      setState(() {
                        if (formKey.currentState!.validate()) {
                          roundIndicator = true;
                        }
                      });
                      String uniqueName =
                          '${DateTime.now().toString().substring(0, 10)}-${DateTime.now().millisecondsSinceEpoch}';

                      if (formKey.currentState!.validate()) {
                        final tomorrow = currentDateInDateFormat!
                            .subtract(const Duration(days: 1));

                        services.uploadEventData(
                            eventNameController.text,
                            locationController.text,
                            rememberController.text,
                            Timestamp.fromDate(currentDateInDateFormat!),
                            uniqueName,
                            mode,
                            Timestamp.fromDate(tomorrow));
                        Timer(const Duration(seconds: 2), () {
                          navigateToEventPage();
                        });
                      }
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToEventPage() {
    FocusScope.of(context).unfocus();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);
  }

  Future<void> selectCurrentDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    initst = DateTime.now();

    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(date.toString()));
    setState(() {
      currentDate = formattedDate;
      currentDateInDateFormat = date;
    });
  }
}
