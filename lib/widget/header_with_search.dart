import 'package:flutter/material.dart';
import 'package:news_api/screen/search.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';

class HeaderWithSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: screenHeight * .17,
      child: LayoutBuilder(
        builder: (context,constrains) {
          double localHeight = constrains.maxHeight;
          double localWidth = constrains.maxWidth;
          return Stack(
              children: [
                Container(
                  height: localHeight * .87 ,
                  decoration: BoxDecoration(
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('Egypt News',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                              color: Colors.white,
                            )),
                        const Spacer(),
                        Image.asset('asset/news_logo.png', height: localHeight * .45, width: localWidth * .15,)
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      // كلمة تبقي في نص الكونتينر TextFeild  //
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: localHeight * .4,
                      decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: KPrimaryColor.withOpacity(.30),
                              blurRadius: 50,
                              offset: Offset(0, 10))
                          // الظل يبقي من تحت ومن اليمين والشمال صفر  //
                        ],
                      ),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          showSearch(context: context, delegate: Search());
                        },
                        decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle:  TextStyle(
                              fontSize: 14.sp,
                                color: KPrimaryColor.withOpacity(.7)),
                            enabledBorder: InputBorder.none,
                            // لازالة البوردر الخارجي قبل الفوكس  //
                            focusedBorder: InputBorder.none,
                            // لازالة البوردر عند الفوكس   //
                            suffixIcon: const Icon(Icons.search)
                        ),
                      ),
                    ))
              ],
            );},
      ));
        }


  }


