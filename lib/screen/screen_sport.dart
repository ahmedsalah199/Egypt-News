import 'package:flutter/material.dart';
import 'package:news_api/widget/body_category.dart';
class ScreenSports extends StatelessWidget {
  const ScreenSports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BodyHomeCategory(category: 'sports');
  }
}
