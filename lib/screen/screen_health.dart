import 'package:flutter/material.dart';
import 'package:news_api/widget/body_category.dart';
class ScreenHealth extends StatelessWidget {
  const ScreenHealth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyHomeCategory(category: 'Health');
  }
}
