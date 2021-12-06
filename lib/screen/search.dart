import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/models/article.dart';
import 'package:news_api/provider/news_service.dart';
import 'package:news_api/screen/web_view_screen.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: KPrimaryColor
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),

      textTheme: TextTheme(
        headline6: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp,color: Colors.white),
      ),
    );
  }
  @override
  List<Widget> buildActions(BuildContext context) {
   return [
      IconButton(onPressed: (){
       query = '' ;
      }, icon:  Icon(Icons.close, color: Colors.white,size:MediaQuery.of(context).size.height * .03,))
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    if(getOS() == "ios") {
      return CupertinoNavigationBarBackButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        color: Colors.white,
      );
    }
    else
    return IconButton(onPressed: (){
      close(context, null);
    }, icon:  Icon(Icons.arrow_back, color: Colors.white,size: MediaQuery.of(context).size.height * .03 ,));

  }
  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: NewsService().FetchData(),
        builder: (context, AsyncSnapshot<List<Article>> snap) {
          if (snap.hasData) {
            List<Article> filter = snap.data!.where((element) => element.title!.toString().toLowerCase().contains(query.toLowerCase())).toList();
            return ListView.builder(
              itemCount: filter.length,
              itemBuilder: (BuildContext context, int index) {
                  return query == '' ? Text('') : InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            WebViewScreen(
                                url: filter[index].url.toString()),
                      ));
                    },
                    child: cardSearchNews(filter, index, screenHeight * .24, screenWidth),
                  );
                },

            );
          }
          else if(snap.hasError){print (snap.error);}
          return Center(child: CircularProgressIndicator());
        });

  }
  Card cardNews( List<Article> filter, int index) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: KPrimaryColor.withOpacity(.3))),
      margin: EdgeInsets.all(15),
      child: Container(
        width: 405,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filter[index].urlToImage != null
                ? ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.network(
                  filter[index].urlToImage.toString(),
                  fit: BoxFit.cover, height: 155,width: 150,))
                : ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Image.asset(
                  'asset/error_news1.jpg',
                  height: 155,width: 150,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 4,
            ),
            Container(
              width: 205,
              height: 155,
              child: Column(
                children: [
                  Container(
                    height: 115,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 3,
                          bottom: 5,
                          top: 8
                      ),
                      child: Text(
                        filter[index].title.toString(),
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 180,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 3,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        filter[index].publishedAt.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Card cardSearchNews( List<Article> filter, int index, height, width) {
    return Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: KPrimaryColor.withOpacity(.3))),
        margin: const EdgeInsets.only(
          top: 10,
          right: 14,
          left: 14,
          bottom: 10,
        ),
        child: Container(
          width: width,
          height: height,
          child: LayoutBuilder(builder: (context, constrains) {
            double localHeight = constrains.maxHeight;
            double localWidth = constrains.maxWidth;
            return Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filter[index].urlToImage != null
                    ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      filter[index].urlToImage.toString(),
                      fit: BoxFit.cover,
                      height: localHeight,
                      width: localWidth * .4,
                    ))
                    : ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'asset/error_news1.jpg',
                      height: localHeight,
                      width: localWidth * .4,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: localWidth * .02,
                ),
                Container(
                  width: localWidth * .55,
                  height: localHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: localHeight * .6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 3, bottom: 5, top: 8),
                            child: Text(
                              filter[index].title.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: localHeight * .17,
                        width: localWidth * .7,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            filter[index].publishedAt.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ));
  }

}