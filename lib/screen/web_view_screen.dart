import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    if (getOS() == "ios") {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
          ),
          backgroundColor: KPrimaryColor,
          middle: Text('Egypt News',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: Colors.white)),
        ),
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {Navigator.of(context).pop();},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * .036,
              )),
          backgroundColor: KPrimaryColor,
          title: Text('Egypt News',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
  }
}
