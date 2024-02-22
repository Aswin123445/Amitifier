import 'dart:typed_data';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/events_add_page/events_add_page.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class EventsPage extends StatefulWidget {
  static const routerName = '/eventsPage';
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Map<String, dynamic>> data = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Duration? diff;
  static FirebaseAuthServices services = FirebaseAuthServices();
  void getData() async {
    data = await services.fetchUpcomingEventData();
    if (mounted) {
      setState(() {});
    }
  }

  void initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // You can now use this plugin to schedule alarms or handle notifications in your app.
  }

  NotificationDetails createNotificationDetails() {
    final androidDetails = AndroidNotificationDetails(
      'channel_id', // Your channel ID here (unique and important)
      'channel_name', // Your channel name
      channelDescription: 'Description of your channel',
      importance: Importance.high, // Set appropriate importance level
      priority: Priority.high,
      playSound: true, // Play a sound if desired
      sound: const RawResourceAndroidNotificationSound(
        'music',
      ), // Use a sound resource if set
      vibrationPattern: Int64List.fromList(
        [0, 1000, 500, 2000],
      ), // Vibration pattern (optional)
    );

    return NotificationDetails(
      android: androidDetails,
    );
  }

  Future<void> scheduleNotification() async {
    final dateData = await services.fetchUpcomingEventData();

    for (int i = 0; i < dateData.length; i++) {
      final d1 = DateTime.now();
      final d2 =
          dateData[i]['Date of Event'].toDate().add(const Duration(hours: 9));
      final differce = d2.difference(d1);
      if (!differce.isNegative) {
        tz.initializeTimeZones(); // Initialize timezone database

        final location =
            tz.getLocation('Asia/Kolkata'); // IST time zone for Kerala

        int notificationId = i; // Unique ID for your notification
        final scheduledTime = TZDateTime.from(
          dateData[i]['Date of Event'].toDate().add(
                const Duration(hours: 8, minutes: 5),
              ),
          // DateTime.now().add(
          //   Duration(seconds: minutes),
          // ),
          location,
        );
        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          dateData[i]['mode'],
          'Don\'t forget the program at ${dateData[i]['Location']}',
          scheduledTime,
          createNotificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation
                  .absoluteTime, // Optional for precise matching
        );
      }
    }
  }

  @override
  void initState() {
    getData();
    AndroidAlarmManager.initialize();
    initializeNotifications();
    scheduleNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        alignment: Alignment.topLeft,
                        height: 6.h,
                        width: 59.w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomText(
                              text: 'Le',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 10.w,
                            ),
                            CustomText(
                              text: 't',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 3.w,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                              text: 'Am',
                              size: 24.sp,
                              containerWidth: 14.4.w,
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
                              text: 't',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 3.4.w,
                            ),
                            CustomText(
                              text: 'i',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 2.w,
                            ),
                            CustomText(
                              text: 'f',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 3.3.w,
                            ),
                            CustomText(
                              text: 'i',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                              containerWidth: 2.w,
                            ),
                            CustomText(
                              text: 'er',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 12.3.w,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w),
                        alignment: Alignment.topLeft,
                        height: 7.h,
                        width: 62.w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomText(
                              text: 'P',
                              size: 24.sp,
                              containerWidth: 5.4.w,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'l',
                              size: 24.sp,
                              containerWidth: 2.w,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 'an',
                              size: 24.sp,
                              containerWidth: 11.w,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomText(
                              text: 'Y',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 5.w,
                            ),
                            CustomText(
                              text: 'o',
                              size: 24.sp,
                              containerWidth: 4.9.w,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 'ur',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 9.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomText(
                              text: 'Da',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 11.7.w,
                            ),
                            CustomText(
                              text: 'Y',
                              size: 24.sp,
                              containerWidth: 5.6.w,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.h),
                    height: 13.h,
                    width: 35.w,
                    child: Lottie.asset('asset/animations/eventfemales.json'),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              InkWell(
                onTap: () {
                  navigateToEventsAddPage();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 20.h,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(128, 205, 254, 255),
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(
                      color: const Color.fromARGB(255, 171, 5, 163),
                      width: 2.sp,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 13.w, top: 1.h),
                            margin: EdgeInsets.only(top: 3.h, right: 5.w),
                            height: 8.h,
                            width: 60.w,
                            child: Icon(
                              Icons.add,
                              size: 40.sp,
                              color: const Color.fromARGB(255, 228, 2, 186),
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                            width: 20.w,
                            child:
                                Lottie.asset('asset/animations/reminder.json'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 33.w),
                        child: CustomText(
                          text: 'Events',
                          size: 20.sp,
                          fontWeight: FontWeight.bold,
                          containerWidth: 25.w,
                          color: const Color.fromARGB(255, 73, 72, 72),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                height: 6.h,
                width: 100.w,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4.w),
                      padding: EdgeInsets.only(top: .4.h),
                      child: CustomText(
                        text: 'Scheduled',
                        size: 19.sp,
                        fontWeight: FontWeight.bold,
                        containerWidth: 35.w,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.w),
                      padding: EdgeInsets.only(top: .4.h),
                      child: CustomText(
                        text: 'Events !',
                        color: const Color.fromARGB(255, 203, 4, 176),
                        size: 20.sp,
                        fontWeight: FontWeight.bold,
                        containerWidth: 35.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                width: 100.w,
                height: 40.h,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Duration duration = calculateDuartaion(
                        data[index]['Date of Event'].toDate());
                    return Column(
                      children: [
                        Container(
                          height: 20.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(164, 212, 250, 255),
                            borderRadius: BorderRadius.circular(1.sp),
                            border: Border.all(
                              color: const Color.fromARGB(255, 209, 7, 196),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 6.h,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 4.h,
                                      margin: EdgeInsets.only(
                                          left: 2.4.w, top: 1.h),
                                      child: CustomText(
                                        text:
                                            '${data[index]['mode'][0].toString().toUpperCase()}${data[index]['mode'].toString().substring(1).toLowerCase()}',
                                        size: 15.5.sp,
                                        fontWeight: FontWeight.bold,
                                        containerWidth: 40.w,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: EdgeInsets.only(top: 1.h),
                                      height: 9.h,
                                      width: 45.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StreamBuilder<Duration>(
                                            stream: timerStream(duration,
                                                data[index]['doc'], context),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final days =
                                                    snapshot.data!.inDays;
                                                final hours =
                                                    snapshot.data!.inHours % 24;
                                                final minutes =
                                                    snapshot.data!.inMinutes %
                                                        60;
                                                final seconds =
                                                    snapshot.data!.inSeconds %
                                                        60;

                                                return Container(
                                                  height: 2.4.h,
                                                  width: 50.w,
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, top: .3.h),
                                                  child: Text(
                                                    ' $days d, $hours h, $minutes m, $seconds s',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.green,
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (!(snapshot.hasData) &&
                                                  snapshot.connectionState ==
                                                      ConnectionState.done) {
                                                services
                                                    .deleteEventsFromList(
                                                        data[index]['doc'],
                                                        context)
                                                    .then(
                                                      (value) =>
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                        const SnackBar(
                                                          content:
                                                              Text('deleted'),
                                                        ),
                                                      ),
                                                    );
                                                return const Text('Alarm hit');
                                              } else {
                                                return const CircularProgressIndicator();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 11.7.h,
                                    width: 50.w,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 3.h,
                                          width: 40.w,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  text: 'Name:',
                                                  size: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 40.sp,
                                                  color: const Color.fromARGB(
                                                      255, 60, 59, 59),
                                                ),
                                                CustomText(
                                                  text:
                                                      '${data[index]['Event Name'][0].toString().toUpperCase()}${data[index]['Event Name'].toString().substring(1).toLowerCase()}',
                                                  size: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 50.w,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 3.h,
                                          width: 40.w,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  text: 'Location:',
                                                  size: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 20.w,
                                                  color: const Color.fromARGB(
                                                      255, 60, 59, 59),
                                                ),
                                                CustomText(
                                                  text:
                                                      '${data[index]['Location'][0].toString().toUpperCase()}${data[index]['Location'].toString().substring(1).toLowerCase()}',
                                                  size: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 40.w,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 3.h,
                                          width: 40.w,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  text: 'Date:',
                                                  size: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 12.w,
                                                  color: const Color.fromARGB(
                                                      255, 60, 59, 59),
                                                ),
                                                CustomText(
                                                  text: DateFormat('dd-MM-yyyy')
                                                      .format(data[index]
                                                              ['Date of Event']
                                                          .toDate()),
                                                  size: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  containerWidth: 40.w,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        margin: EdgeInsets.only(bottom: .1.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 233, 30, 203)),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.sp),
                                          ),
                                        ),
                                        height: 10.7.h,
                                        width: 42.5.w,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 3.h,
                                                padding: EdgeInsets.only(
                                                    left: 3.w, top: .4.h),
                                                child: CustomText(
                                                  text: 'Reminder',
                                                  size: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  containerWidth: 24.w,
                                                ),
                                              ),
                                              if (data[index]['Not Forget'] !=
                                                  'null')
                                                Container(
                                                  height: 5.h,
                                                  width: 30.w,
                                                  margin: EdgeInsets.only(
                                                      top: 1.3.h, left: 6.w),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showAlertDialog(
                                                          context,
                                                          'Reminder',
                                                          '${data[index]['Not Forget']} !');
                                                    },
                                                    child: CustomText(
                                                      text: 'Clik Here',
                                                      size: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      containerWidth: 30.w,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 81, 75, 75),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 30.w, top: 1.h),
                                        height: 4.h,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: IconButton(
                                            onPressed: () {
                                              services.deleteEventsFromList(
                                                  data[index]['doc'], context);
                                            },
                                            icon: const Icon(Icons.delete)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<Duration> timerStream(
      Duration duration, String doc, BuildContext context) async* {
    while (duration.inSeconds > 0) {
      yield duration;
      await Future.delayed(const Duration(seconds: 1));
      duration -= const Duration(seconds: 1);
    }

    // Signal countdown completion
  }

  Duration calculateDuartaion(DateTime dateTime) {
    final now = DateTime.now();
    final targetDate = dateTime; // Replace with your target date
    final difference = targetDate.difference(now);
    return difference + const Duration(hours: 18);
// Handle negative differences (target date has already passed)
  }

  void showAlertDialog(BuildContext context, String dataHead, String dataBody) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            dataHead,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            dataBody,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToEventsAddPage() {
    Navigator.pushNamed(context, EventsAddPage.routerName);
  }
}
