// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_login/screens/homecode/homescreens/events_page.dart';
import 'package:animated_login/screens/homecode/homescreens/friends_page.dart';
import 'package:animated_login/screens/homecode/homescreens/home_page_body.dart';
import 'package:animated_login/screens/homecode/homescreens/settings_page.dart';

//we can give adding friends name option instead ofa asking their birthday
//with tha name and birthday of them also we give funtion to upload images to it
class HomeScreen extends StatefulWidget {
  static int bottomNavigationBarIndex = 0;

  static const String routerName = '/homePage';
  final int? data;
  const HomeScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? number;
  void checking() {
    if (widget.data != null) {
      number = 2;
    }
  }

  @override
  void initState() {
    checking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: (number == 2)
            ? HomeScreen.bottomNavigationBarIndex = 2
            : HomeScreen.bottomNavigationBarIndex,
        onTap: (index) {
          setState(() {
            number = 0;
            HomeScreen.bottomNavigationBarIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 210, 3, 221),
        animationCurve: Curves.linear,
        items: const [
          Icon(
            Icons.home,
          ),
          Icon(
            Icons.people,
          ),
          Icon(
            Icons.event,
          ),
          Icon(
            Icons.settings,
          ),
        ],
        height: 7.h,
      ),
      body: HomeScreen.bottomNavigationBarIndex == 0
          ? const HomePageBody()
          : HomeScreen.bottomNavigationBarIndex == 1
              ? const FriendsPage()
              : HomeScreen.bottomNavigationBarIndex == 2
                  ? const EventsPage()
                  : const SettingsPage(),
    );
  }
}
