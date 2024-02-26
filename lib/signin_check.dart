import 'package:animated_login/screens/authcode/authscreens/phone_number_verification.dart';
import 'package:animated_login/screens/authcode/authscreens/start_page.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninCheck extends StatelessWidget {
  const SigninCheck({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? phoneNumber = snapshot.data!.phoneNumber;
            String? email = snapshot.data!.email;

            if ((phoneNumber != null) && (email != null)) {
              return const HomeScreen();
            } else if ((phoneNumber != null) || (email != null)) {
              return const PhoneNumberVerification();
            }
            // if ((phoneNumber == null) && (email == null)) {
            //   return const StartPage();
            // }
          }
          return const StartPage();
        },
      ),
    );
  }
}
