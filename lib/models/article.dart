import 'package:flutter/cupertino.dart';

class Article {

  String? title ;
  String ? description ;
  String? url ;
  String ?urlToImage ;
  String? publishedAt ;

  Article({
    required this.title, required this.description, required this.url, required this.urlToImage,required this.publishedAt
  });

  factory Article.fromJson(Map<String,dynamic> jsonData){
    return Article(
      title: jsonData["title"]==null? null :  jsonData["title"] ,
      description: jsonData["description"]== null? null :  jsonData["description"],
      urlToImage: jsonData["urlToImage"]== null? null :  jsonData["urlToImage"],
      url: jsonData["url"]==null? null :  jsonData["url"],
      publishedAt: jsonData['publishedAt']==null? null : jsonData['publishedAt']
    );
  }
}