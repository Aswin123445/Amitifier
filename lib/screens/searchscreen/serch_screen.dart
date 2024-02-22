// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_login/globalcustomwidgets/custom_text.dart';
import 'package:animated_login/screens/update_friend_page/friend_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> datas;
  static const routerName = 'searchScreen';
  const SearchScreen({
    Key? key,
    required this.datas,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void navigatToFriendDetailsPage(
      Map<String, dynamic> data, int age, int daysForBirhday) {
    Navigator.pushNamed(context, FriendDetails.routerName,
        arguments: {'data': data, 'age': age, 'days': daysForBirhday});
  }

  // This function is called whenever the text field changes
  List<Map<String, dynamic>> searchData(
      List<Map<String, dynamic>> data, String query) {
    if (query.isEmpty) {
      // Return all data if no query is provided
      return data;
    } else {
      return data
          .where(
              (map) => map['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.white,
                    width: 55.w,
                    height: 14.h,
                    margin: EdgeInsets.only(left: 7.w, top: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'F',
                              containerWidth: 5.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'i',
                              containerWidth: 2.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 'nd',
                              containerWidth: 13.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              containerWidth: 7.w,
                              text: 'fr',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'i',
                              containerWidth: 2.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              containerWidth: 20.w,
                              text: 'ends',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: '!',
                              containerWidth: 2.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: 'On Am',
                              containerWidth: 29.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'i',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              containerWidth: 2.w,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 't',
                              containerWidth: 3.5.w,
                              size: 24.sp,
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
                              text: 'f',
                              size: 24.sp,
                              containerWidth: 3.5.w,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'i',
                              containerWidth: 2.w,
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 181, 0, 153),
                            ),
                            CustomText(
                              text: 'er',
                              size: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 3.w,
                    ),
                    height: 20.h,
                    width: 30.w,
                    child: Lottie.asset('asset/animations/friends.json'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8.w, bottom: 3.h),
                    height: 6.h,
                    width: 70.w,
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
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8.w),
                        hintText: 'Search by name',
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 4.w, top: 3.h),
                    height: 68.h,
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: searchData(widget.datas, searchQuery).length,
                      itemBuilder: (context, index) {
                        final item =
                            searchData(widget.datas, searchQuery)[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => navigatToFriendDetailsPage(
                                  item, item['age'], item['daysForBirhday']),
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w, left: 2.w),
                                height: 7.h,
                                width: 74.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 222, 6, 214),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(11.h))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: '${item['friendprofileurl']}',
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 21.sp,
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: CircleAvatar(
                                          radius: 21.sp,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ), // Display a progress indicator while loading
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons
                                              .error), // Display an error icon if loading fails
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 3.5.h,
                                          child: CustomText(
                                            containerWidth: 20.w,
                                            text:
                                                '${item['name'][0].toString().toUpperCase()}${item['name'].toString().substring(1)}',
                                            size: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          height: 3.h,
                                          padding: EdgeInsets.only(left: 3.w),
                                          child: CustomText(
                                              containerWidth: 20.w,
                                              text:
                                                  ' ${DateFormat('dd-MM-yyyy').format(item['dob'].toDate())}',
                                              size: 8.sp,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.w, bottom: 2.h),
                                      child: CustomText(
                                        containerWidth: 20.w,
                                        text: item['daysForBirhday'] == 365
                                            ? 'today'
                                            : '${item['daysForBirhday']} days',
                                        size: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        );

                        // return ListTile(
                        //   title: Text(item['name']),
                        //   subtitle: Text(item['age'].toString()),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
