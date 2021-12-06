import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_api/adaptive/indicator.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/models/article.dart';
import 'package:news_api/provider//news_service.dart';
import 'package:news_api/screen/web_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: Provider.of<NewsService>(context, listen: false).FetchData(),
        builder: (context, AsyncSnapshot<List<Article>> snap) {
          if (snap.hasData) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (snap.data!.length - 5),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => WebViewScreen(
                            url: snap.data![index + 5].url.toString()),
                      ));
                    },
                    child: cardNewsHomeRow(
                        snap, index, screenHeight * .24, screenWidth),
                  );
                });
          } else if (snap.hasError) {
            print(snap.error);
          }
          return Center(
              child: AdaptiveIndicator(
            os: getOS(),
          ));
        });
  }

  Card cardNewsHomeColumn(AsyncSnapshot<List<Article>> snap, int index) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: KPrimaryColor.withOpacity(.3))),
      margin: EdgeInsets.all(15),
      child: Container(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            snap.data![index + 5].urlToImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                        snap.data![index + 5].urlToImage.toString(),
                        fit: BoxFit.cover))
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'asset/error_news1.jpg',
                      fit: BoxFit.cover,
                    )),
            SizedBox(
              height: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 10),
                    child: Text(
                      snap.data![index + 5].title.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 180,
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      snap.data![index + 5].publishedAt.toString(),
                      textAlign: TextAlign.justify,
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
          ],
        ),
      ),
    );
  }

  Card cardNewsHomeRow(
      AsyncSnapshot<List<Article>> snap, int index, height, width) {
    return Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: KPrimaryColor.withOpacity(.3))),
        margin: const EdgeInsets.only(
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
                snap.data![index + 5].urlToImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        child: Image.network(
                          snap.data![index + 5].urlToImage.toString(),
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
                              snap.data![index + 5].title.toString(),
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
                            snap.data![index + 5].publishedAt.toString(),
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
