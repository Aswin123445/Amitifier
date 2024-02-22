import 'package:animated_login/screens/events_add_page/events_add_page.dart';
import 'package:animated_login/screens/helpcode/help_screen.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_dot_widget.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_event_info.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_inkwell_widget.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:animated_login/screens/searchscreen/serch_screen.dart';
import 'package:animated_login/screens/update_friend_page/friend_details.dart';
import 'package:animated_login/screens/useraccountupdatecode/acountscreen/user_account_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:animated_login/screens/homecode/homecustomwidgets/custom_round_selector.dart';
import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/addfriendpage/add_new_friend_screen/add_new_friend.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';

class HomePageBody extends StatefulWidget {
  static const router = '/homepage';
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

int? age;

class _HomePageBodyState extends State<HomePageBody> {
  String? userName;
  FirebaseAuthServices services = FirebaseAuthServices();
  List<Map<String, dynamic>> firendData = [];
  List<Map<String, dynamic>> topFive = [];
  List<Map<String, dynamic>> eventsData = [];
  //bool checker = false;

  void navigateToAddFriendPage(BuildContext context) {
    Navigator.pushNamed(context, AddNewFriend.routerName);
  }

  void navigateToEventsAddPage() {
    Navigator.pushNamed(context, EventsAddPage.routerName);
  }

  void navigateToUserAccountPage() {
    Navigator.pushNamed(context, UserAccountScreen.routerName,
        arguments: {'noFriends': firendData.length});
  }

  void showAlertDialog(
    BuildContext context,
  ) {
    for (int i = 0; i < firendData.length; i++) {
      if ((firendData[i]['daysForBirhday'] == 15) &&
          firendData[i]['program'] == false) {
        Future.delayed(const Duration(seconds: 4), () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  '${firendData[i]['name']}\'s Birthday',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  firendData[i]['male'] == true
                      ? 'His day coming in 15 days Plan the program'
                      : 'Her day coming in 15 days plan the program',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton(
                    child: const Text('Schedule'),
                    onPressed: () {
                      navigateToEventsAddPage();
                    },
                  ),
                ],
              );
            },
          );
          services.updatefrienddata(firendData[i]['uniqeno'], true);
        });
      }
    }
  }

//we need to chage it to topfive
  void navigateToFriendDetailsPage(int index) {
    Navigator.pushNamed(context, FriendDetails.routerName, arguments: {
      'data': firendData[index],
      'age': age, //firendData[index]['age'],
      'days': firendData[index]['daysForBirhday']
    });
  }

  void navigateToHelpScreen() {
    Navigator.pushNamed(
      context,
      HelpScreen.router,
    );
  }

  final TextEditingController searchController = TextEditingController();
  int carouselCurrentIndex = 0;
  void setcarouselCurrentIndex(int index) {
    if (mounted) {
      setState(() {
        carouselCurrentIndex = index;
      });
    }
  }

  void fetchDatatoScreen() async {
    topFive = await services.fetchFriendData();
    arrangeFriendData();

    for (int i = 0; i < firendData.length; i++) {
      final uniId = firendData[i]['uniqeno'];
      DateTime dob = firendData[i]['dob'].toDate();
      DateTime currentTime = DateTime.now();
      bool isBirthdayPassedThisYear = currentTime.month > dob.month ||
          (currentTime.month == dob.month && currentTime.day >= dob.day);
      int nextBirthdayYear =
          isBirthdayPassedThisYear ? currentTime.year + 1 : currentTime.year;
      DateTime nextBirthday = DateTime(nextBirthdayYear, dob.month, dob.day);
      int daysUntilBirthday = nextBirthday.difference(currentTime).inDays;

      final age1 = currentTime.year - dob.year;

      await services.updateFriendAge(
          daysUntilBirthday, Timestamp.fromDate(nextBirthday), uniId, age1);
      //setState(() {});
    }

    if (mounted) {
      setState(() {});
    }
  }

  void arrangeFriendData() {
    if (firendData.length < topFive.length) {
      for (int i = 0; i < topFive.length; i++) {
        if (topFive[i]['daysForBirhday'] == 365 &&
            (topFive[i]['dob'].toDate().day == DateTime.now().day)) {
          firendData.add(topFive[i]);
        }
      }
      for (int j = 0; j < topFive.length; j++) {
        if (topFive[j]['daysForBirhday'] != 365) firendData.add(topFive[j]);
      }
    }
  }

  void ageCalculator(int index) {
    DateTime dob = firendData[index]['dob'].toDate();
    DateTime currentTime = DateTime.now();

    setState(() {
      age = currentTime.year - dob.year;
    });
  }

  void setTrueorFalse() {
    Future.delayed(const Duration(seconds: 5), () {
      for (int i = 0; i < firendData.length; i++) {
        final doc = firendData[i]['uniqeno'];
        if (firendData[i]['daysForBirhday'] > 15) {
          services.updatefrienddata(doc, false);
        }
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fetchDatatoScreen();
        Future.delayed(const Duration(seconds: 5), () {
          showAlertDialog(context);
        });
      });

      // ubdateFriendDetails();
    });
    setUserName();
    getEventsdata();
    setTrueorFalse();
    super.initState();
  }

  void getEventsdata() async {
    eventsData = await services.fetchUpcomingEventData();
    setState(() {});
  }

  void setUserName() async {
    if (mounted) {
      userName = await services.fetchUserName();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return userName != null
        ? SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: CustomText(
                                        containerWidth: 21.w,
                                        text: 'Helo ',
                                        size: 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (userName != null)
                                      CustomText(
                                        overflow: TextOverflow.ellipsis,
                                        containerWidth: 27.w,
                                        text:
                                            '${userName![0].toString().toUpperCase()}${userName.toString().substring(1).toLowerCase()}!',
                                        color: const Color.fromARGB(
                                            255, 190, 8, 223),
                                        size: 23.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5.w),
                                  alignment: Alignment.bottomLeft,
                                  child: CustomText(
                                    containerWidth: 40.w,
                                    text: "Amitifier",
                                    size: 21.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 11.h,
                            width: 35.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 35.w,
                                  height: 16.h,
                                  child: Lottie.asset(
                                    'asset/animations/home.json',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        height: 15.w,
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              alignment: Alignment.bottomLeft,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  CustomText(
                                    containerWidth: 25.w,
                                    text: 'Makes',
                                    size: 21.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: .4.w,
                                  ),
                                  CustomText(
                                    containerWidth: 39.w,
                                    text: 'Friendship',
                                    size: 21.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: .4.w,
                                  ),
                                  CustomText(
                                    containerWidth: 27.w,
                                    text: 'Strong',
                                    size: 21.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 9.h,
                        width: 35.w,
                        margin: EdgeInsets.only(left: 1.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: CustomRoundSelector(
                                    onTap: navigateToUserAccountPage,
                                    icon: Icon(
                                      Icons.perm_identity_rounded,
                                      color: const Color.fromARGB(
                                          255, 221, 48, 248),
                                      size: 30.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                CustomRoundSelector(
                                  onTap: () => navigateToHelpScreen(),
                                  icon: Icon(
                                    Icons.live_help,
                                    color:
                                        const Color.fromARGB(255, 221, 48, 248),
                                    size: 30.sp,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 3.h,
                              width: 35.w,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5.3.w,
                                  ),
                                  CustomText(
                                    containerWidth: 10.w,
                                    text: 'You',
                                    size: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 5.8.w,
                                  ),
                                  CustomText(
                                    text: 'Help?',
                                    containerWidth: 13.w,
                                    size: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateToSearchScreen(firendData);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 4.w),
                          height: 6.h,
                          width: 56.w,
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
                              Lottie.asset(
                                'asset/animations/search.json',
                                width: 12.w,
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              SizedBox(
                                width: 30.w,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    scrollPhysics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    autoPlay: true,
                                  ),
                                  items: [
                                    CustomText(
                                      text: 'search name',
                                      size: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 105, 104, 102),
                                    ),
                                    CustomText(
                                      text: 'find friends',
                                      size: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 105, 104, 102),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 10.h,
                    width: 65.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: CarouselSlider(
                      items: [
                        SizedBox(
                          height: 3.h,
                          width: 60.w,
                          child: Image.asset(
                            'asset/images/homeslider.png',
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                          width: 60.w,
                          child: Image.asset('asset/images/homeslider.png'),
                        ),
                      ],
                      options: CarouselOptions(
                        viewportFraction: .9,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setcarouselCurrentIndex(index);
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 46.w,
                      ),
                      CustomDotWidget(
                        dotColor: carouselCurrentIndex == 0
                            ? const Color.fromARGB(255, 213, 7, 227)
                            : Colors.blue,
                      ),
                      CustomDotWidget(
                        dotColor: carouselCurrentIndex == 1
                            ? const Color.fromARGB(255, 213, 7, 227)
                            : Colors.blue,
                      ),
                    ],
                  ),
                  Container(
                    height: 6.h,
                    padding: EdgeInsets.only(left: 1.w),
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 3.w, right: 7.w),
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomText(
                          text: 'Big',
                          containerWidth: 10.w,
                          size: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: 'Days',
                          containerWidth: 15.w,
                          size: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: '!',
                          containerWidth: 1.w,
                          size: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 212, 0, 255),
                        ),
                        SizedBox(
                          width: 23.w,
                        ),
                        CustomText(
                          text: 'Programmes',
                          containerWidth: 35.w,
                          size: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: .2.w,
                        ),
                        CustomText(
                          text: '!',
                          size: 17.sp,
                          fontWeight: FontWeight.w600,
                          containerWidth: 1.w,
                          color: const Color.fromARGB(255, 212, 0, 255),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (firendData.isNotEmpty)
                        CustomEventInfo(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                firendData.length > 5 ? 5 : firendData.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  ageCalculator(index);

                                  navigateToFriendDetailsPage(index);
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    color: const Color.fromARGB(
                                        193, 225, 214, 255),
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  margin: EdgeInsets.only(
                                    left: 1.8.w,
                                    top: 1.h,
                                    right: 1.w,
                                  ),
                                  height: 20.h,
                                  width: 40.5.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            margin: EdgeInsets.only(
                                                top: 1.h, left: 1.w),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${firendData[index]['friendprofileurl']}',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 21.sp,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: CircleAvatar(
                                                  radius: 21.sp,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                ),
                                              ), // Display a progress indicator while loading
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                radius: 21.sp,
                                                child: const Icon(Icons.error),
                                              ), // Display an error icon if loading fails
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: .8.w, top: 1.2.h),
                                                alignment: Alignment.topLeft,
                                                width: 22.w,
                                                height: 3.4.h,
                                                child: Text(
                                                  '${firendData[index]['name'][0].toString().toUpperCase()}${firendData[index]['name'].toString().substring(1).toLowerCase()}',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 17, 133, 30),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                width: 24.w,
                                                height: 3.h,
                                                margin:
                                                    EdgeInsets.only(left: .8.w),
                                                child: CustomText(
                                                  containerWidth: 28.w,
                                                  text:
                                                      'Nick:${firendData[index]['nickName']}',
                                                  size: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 36, 30, 30),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (firendData[index]['daysForBirhday'] ==
                                          0)
                                        Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 4.w),
                                                      ),
                                                      CustomText(
                                                        text: 'i',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 't',
                                                        size: 15.sp,
                                                        containerWidth: 2.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: '\'',
                                                        size: 15.sp,
                                                        containerWidth: .9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 's',
                                                        size: 15.sp,
                                                        containerWidth: 2.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 1.w)),
                                                      CustomText(
                                                        text: ' H',
                                                        size: 15.sp,
                                                        containerWidth: 5.9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'i',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 's',
                                                        size: 15.sp,
                                                        containerWidth: 4.9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'Da',
                                                        size: 15.sp,
                                                        containerWidth: 7.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'y',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                ),
                                                Center(
                                                  child: CustomText(
                                                    text: 'Tomorrow',
                                                    size: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    containerWidth: 30.w,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.w),
                                              padding:
                                                  EdgeInsets.only(bottom: 2.h),
                                              height: 12.h,
                                              width: 30.w,
                                              child: LottieBuilder.asset(
                                                'asset/animations/birthday.json',
                                                height: 40.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (firendData[index]['daysForBirhday'] ==
                                          365)
                                        Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 4.w),
                                                      ),
                                                      CustomText(
                                                        text: 'i',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 't',
                                                        size: 15.sp,
                                                        containerWidth: 2.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: '\'',
                                                        size: 15.sp,
                                                        containerWidth: .9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 's',
                                                        size: 15.sp,
                                                        containerWidth: 2.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 1.w)),
                                                      CustomText(
                                                        text: ' H',
                                                        size: 15.sp,
                                                        containerWidth: 5.9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'i',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                      CustomText(
                                                        text: 's',
                                                        size: 15.sp,
                                                        containerWidth: 4.9.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'Da',
                                                        size: 15.sp,
                                                        containerWidth: 7.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      CustomText(
                                                        text: 'y',
                                                        size: 15.sp,
                                                        containerWidth: 1.5.w,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 181, 0, 153),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                ),
                                                Center(
                                                  child: CustomText(
                                                    text: '    Today',
                                                    size: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    containerWidth: 30.w,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.w),
                                              padding:
                                                  EdgeInsets.only(bottom: 2.h),
                                              height: 12.h,
                                              width: 30.w,
                                              child: LottieBuilder.asset(
                                                'asset/animations/birthday.json',
                                                height: 40.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if ((firendData[index]
                                                  ['daysForBirhday'] !=
                                              0) &&
                                          (firendData[index]
                                                  ['daysForBirhday'] !=
                                              365))
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5.5.w,
                                                  ),
                                                  CustomText(
                                                    text: 'B',
                                                    size: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    containerWidth: 3.5.w,
                                                  ),
                                                  CustomText(
                                                    text: 'i',
                                                    size: 15.sp,
                                                    containerWidth: 1.5.w,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 181, 0, 153),
                                                  ),
                                                  CustomText(
                                                    text: 'rthda',
                                                    size: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    containerWidth: 14.4.w,
                                                  ),
                                                  CustomText(
                                                    text: 'y',
                                                    size: 15.sp,
                                                    containerWidth: 5.w,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 181, 0, 153),
                                                  ),
                                                  SizedBox(
                                                    width: .2.w,
                                                  ),
                                                  CustomText(
                                                    text: 'I',
                                                    size: 15.sp,
                                                    containerWidth: 1.4.w,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 181, 0, 153),
                                                  ),
                                                  CustomText(
                                                    text: 'n',
                                                    size: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    containerWidth: 3.5.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${firendData[index]['daysForBirhday']} Days',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      if (firendData.isEmpty)
                        CustomEventInfo(
                          child: Column(
                            children: [
                              Lottie.asset('asset/animations/nodata.json'),
                              TextButton(
                                onPressed: () {
                                  navigateToAddFriendPage(context);
                                },
                                child: CustomText(
                                  text: 'Add Friends',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  containerWidth: 30.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (eventsData.isEmpty)
                        CustomEventInfo(
                          child: Column(
                            children: [
                              Lottie.asset('asset/animations/nodata.json'),
                              TextButton(
                                onPressed: () {
                                  navigateToAddEventPage();
                                },
                                child: CustomText(
                                  text: 'Add Events',
                                  size: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  containerWidth: 30.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (eventsData.isNotEmpty)
                        CustomEventInfo(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                eventsData.length < 5 ? eventsData.length : 5,
                            itemBuilder: ((context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      HomeScreen.bottomNavigationBarIndex == 2;
                                      setState(() {});
                                      navigatToHomeScreen();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            193, 225, 214, 255),
                                        border: Border.all(width: 1),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            blurRadius: 2,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 1.8.w, top: 1.h),
                                      height: 20.h,
                                      width: 40.5.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 4.h,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                            margin: EdgeInsets.only(
                                                top: 1.h, left: 2.w),
                                            child: CustomText(
                                              text: ' Reminder!',
                                              containerWidth: 30.w,
                                              color: const Color.fromARGB(
                                                  255, 17, 133, 30),
                                              size: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 1.w,
                                              top: 1.h,
                                            ),
                                            height: 3.5.h,
                                            padding:
                                                EdgeInsets.only(left: 5.sp),
                                            child: CustomText(
                                              containerWidth: 37.w,
                                              text:
                                                  '${eventsData[index]['mode']![0].toString().toUpperCase()}${eventsData[index]['mode'].toString().substring(1).toLowerCase()}',
                                              size: 13.5.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 2.5.w),
                                                padding: EdgeInsets.only(
                                                    bottom: 1.h),
                                                height: 3.5.h,
                                                child: CustomText(
                                                  containerWidth: 37.w,
                                                  text:
                                                      'At ${eventsData[index]['Location']}',
                                                  size: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.5.h,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w),
                                                  child: CustomText(
                                                    containerWidth: 14.w,
                                                    text: 'Date :',
                                                    size: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 36, 30, 30),
                                                  ),
                                                ),
                                                Container(
                                                  width: 22.w,
                                                  padding: EdgeInsets.only(
                                                      top: .4.h),
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: CustomText(
                                                    containerWidth: 22.w,
                                                    text: DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(eventsData[
                                                                    index][
                                                                'Date of Event']
                                                            .toDate()),
                                                    size: 9.4.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomInkwellButton(
                        text: 'Add Friend',
                        ontap: () {
                          navigateToAddHomePage();
                        },
                      ),
                      CustomInkwellButton(
                        text: 'Add Event',
                        ontap: () {
                          navigateToAddEventPage();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox(
            child: LottieBuilder.asset(
              'asset/animations/shimmer.json',
              fit: BoxFit.fitHeight,
              height: 100.h,
            ),
          );
  }

  void navigateToAddEventPage() {
    Navigator.pushNamed(context, EventsAddPage.routerName);
  }

  void navigatToHomeScreen() {
    Navigator.pushNamed(context, HomeScreen.routerName, arguments: 2);
  }

  void navigateToSearchScreen(List<Map<String, dynamic>> data) {
    Navigator.pushNamed(context, SearchScreen.routerName, arguments: data);
  }

  void navigateToAddHomePage() {
    Navigator.pushNamed(
      context,
      AddNewFriend.routerName,
    );
  }
}
