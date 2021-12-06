import 'package:flutter/foundation.dart';
import 'package:news_api/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService extends ChangeNotifier{
  static const String apiKey = '33de4d3f0cc140d78a2cdfdf68147e1d';

  Future<List<Article>> FetchData() async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data["articles"];
      List<Article> articlesList =
          articles.map((e) => Article.fromJson(e)).toList();
      return articlesList;
    }
    else {
      throw ('statusCode = ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<List<Article>> FetchDataByCatalog(String category) async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data["articles"];
      List<Article> articlesList =
          articles.map((e) => Article.fromJson(e)).toList();
      return articlesList;
    } else {
      throw ('statusCode = ${response.statusCode}');
    }
    notifyListeners();

  }
}
