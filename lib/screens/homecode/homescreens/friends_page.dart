import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/addfriendpage/add_new_friend_screen/add_new_friend.dart';
import 'package:animated_login/screens/searchscreen/serch_screen.dart';
import 'package:animated_login/screens/update_friend_page/friend_details.dart';
import 'package:animated_login/services/firebase_services/firebase_servies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class FriendsPage extends StatefulWidget {
  static bool friendChecker = false;
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  int? age;
  int? daysToBirthday;
  final FirebaseAuthServices services = FirebaseAuthServices();
  List<Map<String, dynamic>> friendData = [];
  void fetchDatatoScreen() async {
    friendData = await services.fetchFriendData();
    if (mounted) {
      setState(() {});
    }
  }

  void navigateToSearchScreen(List<Map<String, dynamic>> data) {
    Navigator.pushNamed(context, SearchScreen.routerName, arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    fetchDatatoScreen();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 6.w, top: 2.h),
                  color: Colors.white,
                  alignment: Alignment.bottomLeft,
                  width: 60.w,
                  height: 14.h,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'Amitifier',
                            containerWidth: 40.w,
                            size: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: '!',
                            size: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 205, 8, 192),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateToSearchScreen(friendData);
                        },
                        child: Container(
                          height: 5.h,
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
                ),
                Container(
                  padding: EdgeInsets.only(top: 1.h),
                  color: Colors.white,
                  height: 15.h,
                  width: 33.w,
                  child: Lottie.asset('asset/animations/friends.json'),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 2.h),
              child: CustomText(
                text: 'Your Friends',
                containerWidth: 60.w,
                size: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            if (friendData.isEmpty)
              Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 55.h,
                color: Colors.white,
                child: CustomText(
                  text: 'No Friends Yet',
                  containerWidth: 80.w,
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 92, 90, 89),
                ),
              ),
            if (friendData.isNotEmpty)
              Container(
                width: 100.w,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 55.5.h,
                child: ListView.builder(
                  itemCount: friendData.length,
                  itemBuilder: (context, index) {
                    //print(index);
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            ageCalculator(index);
                            navigateToFriendDetailsPage(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 0.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.sp),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(75, 196, 17, 178)
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(1, 2),
                                ),
                              ],
                              border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 232, 14, 192),
                              ),
                            ),
                            height: 10.h,
                            width: 90.w,
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 10.h,
                                  width: 20.w,
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error), //
                                    imageUrl:
                                        '${friendData[index]['friendprofileurl']}',
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 30.sp,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: CircleAvatar(
                                          radius: 30.sp,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 4.h,
                                      width: 50.w,
                                      color: Colors.white,
                                      child: CustomText(
                                        containerWidth: 60.w,
                                        overflow: TextOverflow.ellipsis,
                                        text:
                                            '${friendData[index]['name'][0].toString().toUpperCase()}${friendData[index]['name'].toString().substring(1).toLowerCase()}',
                                        size: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      height: 5.h,
                                      width: 50.w,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 2.5.h,
                                            alignment: Alignment.bottomLeft,
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: CustomText(
                                              containerWidth: 60.w,
                                              text:
                                                  'dob : ${DateFormat('dd-MM-yyyy').format(friendData[index]['dob'].toDate())}',
                                              size: 9.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            height: 2.5.h,
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: CustomText(
                                              containerWidth: 60.w,
                                              text:
                                                  'Nick name: ${friendData[index]['nickName']}',
                                              size: 9.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      services.deleteFriendFromCollection(
                                        friendData[index]['uniqeno'],
                                        context,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Deleted'),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(178, 221, 93, 221))),
                // onPressed: ageCalculator,
                onPressed: () {
                  FriendsPage.friendChecker = true;
                  navigateToAddFriendPage();
                  setState(() {});
                },
                child: CustomText(
                  containderHeight: 5.h,
                  containerWidth: 50.w,
                  text: '       Add friend',
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

  void navigateToAddFriendPage() {
    Navigator.pushNamed(context, AddNewFriend.routerName);
  }

  void navigateToFriendDetailsPage(int index) {
    Navigator.pushNamed(context, FriendDetails.routerName, arguments: {
      'data': friendData[index],
      'age': age,
      'days': daysToBirthday
    });
  }

  void ageCalculator(int index) {
    DateTime dob = friendData[index]['dob'].toDate();
    DateTime currentTime = DateTime.now();
    bool isBirthdayPassedThisYear = currentTime.month > dob.month ||
        (currentTime.month == dob.month && currentTime.day >= dob.day);
    int nextBirthdayYear =
        isBirthdayPassedThisYear ? currentTime.year + 1 : currentTime.year;
    DateTime nextBirthday = DateTime(nextBirthdayYear, dob.month, dob.day);
    int daysUntilBirthday = nextBirthday.difference(currentTime).inDays;

    setState(() {
      age = currentTime.year - dob.year;
      daysToBirthday = daysUntilBirthday;
    });
  }
}
