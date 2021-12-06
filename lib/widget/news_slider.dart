import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_api/adaptive/indicator.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/models/article.dart';
import 'package:news_api/provider/news_service.dart';
import 'package:news_api/screen/web_view_screen.dart';
import 'package:sizer/sizer.dart';

class NewsSlider extends StatefulWidget {
  @override
  _NewsSliderState createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: NewsService().FetchData(),
        builder: (context, AsyncSnapshot<List<Article>> snap) {
          if (snap.hasData) {
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (_, number, page) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => WebViewScreen(
                              url: snap.data![number].url.toString()),
                        ));
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: LayoutBuilder(
                          builder: (context,constrains){
                            double localHeight = constrains.maxHeight;
                            double localWidth = constrains.maxWidth;
                           return Stack(
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight * .30,
                                child: snap.data![number].urlToImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          snap.data![number].urlToImage.toString(),
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Image.asset(
                                          'asset/error_news1.jpg',
                                          fit: BoxFit.cover,
                                        )),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    width: localWidth,
                                    height:localHeight * .42,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Text(
                                        snap.data![number].title.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.start,
                                        textDirection: TextDirection.rtl,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ))
                            ],
                          );},
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      onPageChanged: (index,_) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      initialPage:0 ,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 3)),
                ),
                SizedBox(
                  height: screenHeight * .002,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildContainer(0,screenHeight * .03,screenWidth * .03),
                      buildContainer(1,screenHeight * .03,screenWidth * .03),
                      buildContainer(2,screenHeight * .03,screenWidth * .03),
                      buildContainer(3,screenHeight * .03,screenWidth * .03),
                      buildContainer(4,screenHeight * .03,screenWidth * .03),
                    ],
                  ),
                ),
              ],
            );
          }

          return Center(child: AdaptiveIndicator(os: getOS(),));
        });
  }

  Container buildContainer(int index,height,width ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? Colors.red : Colors.blue),
    );
  }
}
