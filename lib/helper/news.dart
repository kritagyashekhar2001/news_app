import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    print('getnews function reached');
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d0a8d56ef18549cc94e40ef840d02756');
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d0a8d56ef18549cc94e40ef840d02756
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);

      print(jsonData);

      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              urlToImage: element["urlToImage"],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element["content"],
              url: element["url"],
            );
            news.add(article);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
