import 'dart:io';

import 'package:animated_login/globalcustomwidgets/snackbar.dart';
import 'package:animated_login/screens/authcode/authscreens/otp_verification.dart';
import 'package:animated_login/screens/homecode/homescreens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';

class FirebaseAuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance.ref();
  final firestore = FirebaseFirestore.instance.collection('UserData');
  final friendfirestor = FirebaseFirestore.instance.collection('FriendData');
  final eventsReverece =
      FirebaseFirestore.instance.collection('EventsCollecton');

  //logging out user from firebase
  Future<void> logoutUser() async {
    return await auth.signOut();
  }

  //deleting events alarm from collectin
  Future<void> deleteEventsFromList(String docid, BuildContext context) async {
    String? mail = auth.currentUser!.email;
    try {
      await eventsReverece.doc(mail).collection('Events').doc(docid).delete();
      // ignore: use_build_context_synchronously
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('error')));
      // Handle the error appropriately, e.g., notify the user or retry.
    }
  }

//uploading events data of friend
  Future<void> uploadEventData(
      String eventName,
      String location,
      String toRemember,
      Timestamp date,
      String uni,
      String mode,
      Timestamp alarmDay) async {
    String? mail = auth.currentUser!.email;

    final data = {
      'mode': mode,
      'Event Name': eventName,
      'Location': location,
      'Not Forget': toRemember,
      'Date of Event': date,
      'alarm': alarmDay,
      'doc': uni
    };

    // await eventsReverece.doc(mail).set(data);
    eventsReverece.doc(mail).collection('Events').doc(uni).set(data);
  }

  //fetch events data
  Future<List<Map<String, dynamic>>> fetchUpcomingEventData() async {
    String? mail = auth.currentUser!.email;
    List<Map<String, dynamic>> data = [];

    final ref = eventsReverece.doc(mail).collection('Events');

    // Get the current date and time
    final currentDate = DateTime.now().subtract(const Duration(days: 1));

    // Query for events with dates greater than or equal to the current date
    final snapshot = await ref
        .where('Date of Event', isGreaterThanOrEqualTo: currentDate)
        .get();

    data = snapshot.docs.map((e) => e.data()).toList();
    return data;
  }

  //fetch user data to screen

  Future<Map<String, dynamic>> fetchUserDataToScreen() async {
    String? mail = auth.currentUser!.email;
    final userData = await firestore.doc(mail).get();
    final data = userData.data();
    return data!;
  }

  //deleting friend  from collection
  Future<void> deleteFriendFromCollection(
      String docid, BuildContext context) async {
    String? mail = auth.currentUser!.email;
    try {
      await friendfirestor.doc(mail).collection('friends').doc(docid).delete();
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('error')));
      // Handle the error appropriately, e.g., notify the user or retry.
    }
  }

  //ubdating friend profile photo in firestore

  Future<void> updateFriendProfilePhoto(String url, String id) async {
    String? mail = auth.currentUser!.email;
    friendfirestor
        .doc(mail)
        .collection('friends')
        .doc(id)
        .update({'friendprofileurl': url});
  }

  //updating friend profile picture
  Future<String> ubdatingFriendProfile(
    String path,
    XFile image,
  ) async {
    String? mail = auth.currentUser!.email;

    Reference dirRef =
        storage.child(mail!).child('friend_profile').child(path.toString());

    await dirRef.putFile(File(image.path));
    String url = await dirRef.getDownloadURL();
    return url;
  }

  //updating friend name
  Future<void> updateFriendName(String docId, String name) {
    String mail = auth.currentUser!.email.toString();
    Map<String, dynamic> newUserData = {
      'name': name,
    };
    return friendfirestor
        .doc(mail)
        .collection('friends')
        .doc(docId)
        .update(newUserData);
  }

  //update user occupation
  Future<void> udpdateUserOccupation(String occutpation) async {
    String? mail = auth.currentUser!.email.toString();
    Map<String, dynamic> newData = {'Occupation': occutpation};
    return await firestore.doc(mail).update(newData);
  }

  //update user nickName

  Future<void> updateUserNickName(String nickName) async {
    String? mail = auth.currentUser!.email.toString();
    Map<String, dynamic> newData = {'nickName': nickName};
    return await firestore.doc(mail).update(newData);
  }

  //updating user dob
  Future<void> updateUserdob(Timestamp dob, int age) async {
    String? mail = auth.currentUser!.email;
    Map<String, dynamic> newfield = {'dob': dob, 'daystobirthday': age};
    return await firestore.doc(mail).update(newfield);
  }
//updating friend nick name

  Future<void> updateFriendNickName(String docId, String nickName) {
    String mail = auth.currentUser!.email.toString();
    Map<String, dynamic> newUserData = {
      'nickName': nickName,
    };
    return friendfirestor
        .doc(mail)
        .collection('friends')
        .doc(docId)
        .update(newUserData);
  }

  //updating friend description appending with existing data

  Future<void> appendFriendDesWithNewData(String doc, String data) {
    String mail = auth.currentUser!.email.toString();
    return friendfirestor.doc(mail).collection('friends').doc(doc).update({
      'description': FieldValue.arrayUnion([data])
    });
  }

  //deleting a  friend description from list
  Future<void> deleteFriendDescription(String doc, int index) async {
    List<dynamic> newList = [];
    String mail = auth.currentUser!.email.toString();
    final refer = friendfirestor.doc(mail).collection('friends').doc(doc);
    final ducumentSnampshot = await refer.get();
    if (ducumentSnampshot.exists) {
      final data = ducumentSnampshot.data();
      final fieldValue = data!['description'] as List<dynamic>;
      for (int i = 0; i < fieldValue.length; i++) {
        if (i != index) {
          newList.add(fieldValue[i]);
        }
      }
      await refer.update({'description': newList});
    } else {}
  }

  //deleting friend photos from list

  Future<void> deleteFriendPhotolink(String doc, int index) async {
    List<dynamic> newList = [];
    String mail = auth.currentUser!.email.toString();
    final refer = friendfirestor.doc(mail).collection('friends').doc(doc);
    final ducumentSnampshot = await refer.get();
    if (ducumentSnampshot.exists) {
      final data = ducumentSnampshot.data();
      final fieldValue = data!['friendphotos'] as List<dynamic>;
      for (int i = 0; i < fieldValue.length; i++) {
        if (i != index) {
          newList.add(fieldValue[i]);
        }
      }
      await refer.update({'friendphotos': newList});
    } else {}
  }

//adding friends datas to collection
  Future<void> setfriendsDat(
    int daysUntilbir,
    Timestamp nextbirthday,
    String nickName,
    String name,
    List<String> friendDescription,
    bool isMale,
    Timestamp dob,
    String friendurl,
    List<String>? urls,
  ) {
    String mail = auth.currentUser!.email.toString();
    final String uniqueValue = DateTime.now().toString();

    return friendfirestor.doc(mail).collection('friends').doc(uniqueValue).set({
      'next birhday': nextbirthday,
      'daysForBirhday': daysUntilbir,
      'name': name,
      'nickName': nickName,
      'description': friendDescription,
      'male': isMale,
      'dob': dob,
      'friendprofileurl': friendurl,
      'friendphotos': urls,
      'uniqeno': uniqueValue,
      'program': false
    }).then((value) => null);
  }

  Future<void> updatefrienddata(String doc, bool type) async {
    String? mail = auth.currentUser!.email;
    final data = {'program': type};
    return await friendfirestor
        .doc(mail)
        .collection('friends')
        .doc(doc)
        .update(data);
  }

  //updating friend photos to firestore

  Future<void> updateFriendPhotosLink(String uniqueValue, List url) {
    String mail = auth.currentUser!.email.toString();
    return friendfirestor
        .doc(mail)
        .collection('friends')
        .doc(uniqueValue)
        .update(
      {'friendphotos': FieldValue.arrayUnion(url)},
    );
  }

  //uploading images to ui from firestore
  Future<String> downLoadProfilePhoto() async {
    String? mail = auth.currentUser!.email;
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.doc(mail).get();
    String imageurl = snapshot.data()!['userphotourl'];
    return imageurl;
  }

  //uploading friend profile image
  Future<String> friendProfilePhoto(
    String path,
    XFile image,
  ) async {
    String? mail = auth.currentUser!.email;
    Reference dir = storage.child(mail!).child('friend_profile');

    Reference dirRef = dir.child(path);

    await dirRef.putFile(File(image.path));
    String url = await dirRef.getDownloadURL();
    return url;
  }
  //adding list of files of friends

  //adding friends photos
  Future<String> friendsPhotos(
    String path,
    XFile image,
  ) async {
    String? mail = auth.currentUser!.email;
    Reference dir = storage.child(mail!).child('friends_photos');

    Reference dirRef = dir.child(path);

    await dirRef.putFile(File(image.path));
    String url = await dirRef.getDownloadURL();
    return url;
  }

  //ubdating profile picture
  Future<String> profilePhoto(
    String path,
    XFile image,
  ) async {
    String? mail = auth.currentUser!.email;
    Reference deleCheck = storage.child(mail!).child('profile');
    ListResult? list = await deleCheck.listAll();
    if (list.items.isNotEmpty) {
      list.items[0].delete();
    }

    Reference dirRef = storage.child(mail).child('profile').child(path);

    await dirRef.putFile(File(image.path));
    String url = await dirRef.getDownloadURL();
    return url;
  }

//adding phone to the existing doc
  Future<void> addPhoneNumberToUserData(String phoneNumber) {
    String? mail = auth.currentUser!.email;
    Map<String, dynamic> newUserData = {'PhoneNumber': phoneNumber};
    return firestore.doc(mail).update(newUserData);
  }

  //adding user profile photo link to firestore
  Future<void> addImageToUserData(String url) async {
    String? mail = auth.currentUser!.email;
    Map<String, dynamic> imagelink = {'userphotourl': url};
    return firestore.doc(mail).update(imagelink);
  }

//updating user from profile

  Future<void> updateUserFromProfile(
      String nickName, String occuptaion, Timestamp dob) {
    String? mail = auth.currentUser!.email;
    Map<String, dynamic> newUserData = {
      'NickName': nickName,
      'Occupation': occuptaion,
      'dob': dob
    };
    return firestore.doc(mail).update(newUserData);
  }

  //update number of days to birthday and age

  Future<void> updateFriendAge(
      int daysToBirhday, Timestamp nextBirhday, String id, int age) {
    final mail = auth.currentUser!.email;
    final data = {
      "next birhday": nextBirhday,
      "daysForBirhday": daysToBirhday,
      "age": age
    };
    return friendfirestor.doc(mail).collection('friends').doc(id).update(data);
  }

  Future<void> setUserData(
    String mail,
    String name,
  ) {
    return firestore.doc(mail).set({
      'name': name,
      'email': mail,
    }).then((value) => null);
  }

  Future<User?> signUpWithEmailandPassword(
      String mail, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: mail, password: password);

      return userCredential.user;
    } catch (e) {
      //
    }

    return null;
  }

  Future<User?> signinWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      //
    }
    return null;
  }

  Future<User?> linkPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {}
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                otpverifier: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    //addPhoneNumberToUserData(phoneNumber);

    return null;
  }

  void verifyOtp({
    required BuildContext context,
    required String varificationId,
    required String userOtp,
    required String phoneNumber,
  }) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: varificationId, smsCode: userOtp);
      await auth.currentUser!.linkWithCredential(credential);
      addPhoneNumberToUserData(phoneNumber);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<String> fetchUserName() async {
    String? email = auth.currentUser!.email;

    final field =
        await firestore.doc(email).get().then((doc) => doc.get('name'));
    await Future.delayed(const Duration(seconds: 2));

    return field;
  }

  Future<XFile> assetToXFile(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/image.png';
    final File file = File(path);
    await file.writeAsBytes(data.buffer.asUint8List());
    return XFile(path);
  }

  Future<List<Map<String, dynamic>>> fetchFriendData() async {
    String? mail = auth.currentUser!.email;
    List<Map<String, dynamic>> list = [];
    final collectionRef = friendfirestor.doc(mail).collection('friends');
    Query query = collectionRef.orderBy('daysForBirhday', descending: false);
    QuerySnapshot querySnapshot = await query.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      list.add(data);
    }
    return list;
    //  return docs;
    // final snapshot = await collectionRef.get();
    // final doc = snapshot.docs.map((doc) => doc.data()).toList();
    // return doc;
  }
}
