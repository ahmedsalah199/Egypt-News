import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/provider//news_service.dart';
import 'package:news_api/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp(
    ChangeNotifierProvider<NewsService>(create: (_)=> NewsService(),
      child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(

      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: KPrimaryColor,
          ),
          home: SplashScreen(),

        );
      }
    );
  }
}

