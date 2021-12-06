import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/adaptive/indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';
import 'home_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    Timer(Duration(milliseconds: 3300), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeLayout();
      }));
    });
  }
@override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'asset/splash_screen.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'Egypt News',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05,),
                  Shimmer.fromColors(
                    baseColor: Colors.blue,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'by \n Ahmed Salah',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05,),
                  AdaptiveIndicator(os: getOS()),
                ],
              ),

    ]),
        ));
  }
}
