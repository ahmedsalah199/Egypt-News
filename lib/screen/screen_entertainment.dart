import 'package:flutter/material.dart';
import 'package:news_api/widget/body_category.dart';
class ScreenEntertainment extends StatelessWidget {
  const ScreenEntertainment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyHomeCategory(category: 'Entertainment');
  }
}
