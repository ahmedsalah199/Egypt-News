import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/widget/body_home.dart';
import 'package:news_api/widget/news_slider.dart';
import 'package:news_api/widget/header_with_search.dart';
import 'package:sizer/sizer.dart';

class ScreenHome extends StatefulWidget {
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}
class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        HeaderWithSearch(),
        Expanded(
          child: ListView(
            children: [
              NewsSlider(),
                SizedBox(
                height: screenHeight * .001,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16,bottom: 5),
                height: screenHeight * .05,
                child: Row(
                  children: [
                    Stack(
                      children: [
                         Text(
                          'Latest News :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            height: 5,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: KPrimaryColor.withOpacity(.2))
                            ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              BodyHome()
            ],
          ),
        )
      ],
    );
  }
}
