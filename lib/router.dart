import 'package:animated_login/screens/authcode/authscreens/login_page.dart';
import 'package:animated_login/screens/authcode/authscreens/phone_number_verification.dart';
import 'package:animated_login/screens/authcode/authscreens/register_screen.dart';
import 'package:animated_login/screens/addfriendpage/add_new_friend_screen/add_new_friend.dart';
import 'package:animated_login/screens/events_add_page/events_add_page.dart';
import 'package:animated_login/screens/helpcode/help_screen.dart';
import 'package:animated_login/screens/homecode/homescreens/events_page.dart';
import 'package:animated_login/screens/homecode/homescreens/home_page_body.dart';
import 'package:animated_login/screens/searchscreen/serch_screen.dart';
import 'package:animated_login/screens/update_friend_page/friend_details.dart';
import 'package:animated_login/screens/update_friend_page/friend_photosl.dart';
import 'package:animated_login/screens/useraccountupdatecode/acountscreen/profile_update_screen.dart';
import 'package:animated_login/screens/useraccountupdatecode/acountscreen/user_account_screen.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case PhoneNumberVerification.routeName:
      return MaterialPageRoute(
        builder: (context) => const PhoneNumberVerification(),
      );
    case HomeScreen.routerName:
      int number = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => HomeScreen(
          data: number,
        ),
      );
    case AddNewFriend.routerName:
      return MaterialPageRoute(
        builder: (context) => const AddNewFriend(),
      );
    case UserAccountScreen.routerName:
      final noFriends = settings.arguments as Map<String, int>;
      int? totalFriends = noFriends['noFriends'];
      return MaterialPageRoute(
        builder: (context) => UserAccountScreen(
          numberFriends: totalFriends!,
        ),
      );
    case EventsPage.routerName:
      return MaterialPageRoute(
        builder: (context) => const EventsPage(),
      );
    case ProfileUbdateScreen.routerName:
      return MaterialPageRoute(
        builder: (context) => const ProfileUbdateScreen(),
      );
    case HelpScreen.router:
      return MaterialPageRoute(
        builder: (context) => const HelpScreen(),
      );
    case HomePageBody.router:
      return MaterialPageRoute(
        builder: (context) => const HomePageBody(),
      );
    case FriendDetails.routerName:
      final friendData = settings.arguments as Map<String, dynamic>;
      final data = friendData['data'];
      final age = friendData['age'];
      final days = friendData['days'];
      return MaterialPageRoute(
        builder: (context) => FriendDetails(
          friendData: data,
          age: age,
          daysOfBirthday: days,
        ),
      );
    case SearchScreen.routerName:
      final datas = settings.arguments as List<Map<String, dynamic>>;
      return MaterialPageRoute(
        builder: (context) => SearchScreen(datas: datas),
      );
    case FriendPhots.routerName:
      final photos = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => FriendPhots(
          photosLink: photos,
        ),
      );
    case EventsAddPage.routerName:
      return MaterialPageRoute(
        builder: (context) => const EventsAddPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('error message here'),
            ),
          );
        },
      );
  }
}
