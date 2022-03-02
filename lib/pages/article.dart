import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<Article> articles = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    print('UI getNews called');
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('something');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          imageAssetUrl: categories[index].imageAssetUrl,
                          categoryName: categories[index].categorieName,
                        );
                      }),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return Blogtile(
                          posturl: articles[index].url,
                          imageurl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          content: articles[index].content,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({required this.imageAssetUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              imageAssetUrl,
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.black26),
            child: Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class Blogtile extends StatelessWidget {
  final imageurl, title, desc, content, posturl;

  const Blogtile(
      {Key? key,
      this.imageurl,
      this.title,
      this.desc,
      this.content,
      @required this.posturl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    imageurl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 12,
              ),
              Text(
                title,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                desc,
                maxLines: 2,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
