import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:animated_login/router.dart';
import 'package:animated_login/signin_check.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          onGenerateRoute: (settings) => generateRoute(settings),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Satoshi',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          //home: const FriendsPage(),
          //home: const HomeScreen(),
          home: const SigninCheck(),
          //home: const AddNewFriend(),
        );
      },
    );
  }
}
