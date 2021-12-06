import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/screen/screen_entertainment.dart';
import 'package:news_api/screen/screen_health.dart';
import 'package:news_api/screen/screen_home.dart';
import 'package:news_api/screen/screen_sport.dart';
import 'package:sizer/sizer.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  static const String sports = 'Sports';
  static const String entertainment = 'Entertainment';
  static const String health = 'Health';
  List<Widget> screen = [
    ScreenHome(),
    ScreenSports(),
    ScreenEntertainment(),
    ScreenHealth()
  ];
  static const List<String> title = ['', 'Sports', 'Entertainment', 'Health'];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0
          ? AppBar(
              elevation: 0,
              backgroundColor: KPrimaryColor,
            )
          : AppBar(
              backgroundColor: KPrimaryColor,
              title: Text(
                title[currentIndex],
                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Colors.white,

                    ),
              ),
              centerTitle: true,
            ),
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: KPrimaryColor,
        elevation: 10,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.home,size: MediaQuery.of(context).size.height * .035,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.sports_soccer_outlined,size: MediaQuery.of(context).size.height * .035,),
            label: sports,
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.category,size: MediaQuery.of(context).size.height * .035,),
            label: entertainment,
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.healing,size: MediaQuery.of(context).size.height * .035,),
            label: health,
          ),
        ],
      ),
    );
  }
}
