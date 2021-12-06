import 'package:flutter/material.dart';
import 'package:news_api/adaptive/indicator.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/models/article.dart';
import 'package:news_api/provider//news_service.dart';
import 'package:news_api/screen/web_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BodyHomeCategory extends StatelessWidget {
  final String category;
  BodyHomeCategory({required this.category});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: Provider.of<NewsService>(context, listen: false)
            .FetchDataByCatalog(category),
        builder: (context, AsyncSnapshot<List<Article>> snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => WebViewScreen(
                            url: snap.data![index].url.toString()),
                      ));
                    },
                    child: buildCardNews(
                        snap, index, screenHeight * .5, screenWidth),
                  );
                });
          }
          return Center(
              child: AdaptiveIndicator(
            os: getOS(),
          ));
        });
  }

  Card buildCardNews(
      AsyncSnapshot<List<Article>> snap, int index, height, width) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: KPrimaryColor.withOpacity(.3))),
      margin: const EdgeInsets.only(
        top: 14,
        right: 15,
        left: 15,
      ),
      child: Container(
        width: width,
        height: height,
        child: LayoutBuilder(builder: (context, constrains) {
          double localHeight = constrains.maxHeight;
          double localWidth = constrains.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              snap.data![index].urlToImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        snap.data![index].urlToImage.toString(),
                        fit: BoxFit.cover,
                        height: localHeight * .60,
                        width: localWidth,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        'asset/error_news1.jpg',
                        fit: BoxFit.cover,
                        height: localHeight * .60,
                        width: localWidth,
                      )),
              SizedBox(
                height: localHeight * .001,
              ),
              Container(
                height: localHeight * .28,
                width: localWidth,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 2, top: 5),
                  child: Text(
                    snap.data![index].title.toString(),
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              Container(
                height: localHeight * .09,
                width: localWidth * .6,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 3, top: 4),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    snap.data![index].publishedAt.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
