// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, unnecessary_this, deprecated_member_use, prefer_collection_literals, unnecessary_new, avoid_function_literals_in_foreach_calls, unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '5727a66599614514b4fff72f25e3c302';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] =
          new List<Article>.empty(growable: true);
    });
    //this.getArticulosCategoriaSeleccionada(this._selectedCategory);
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesBycategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesBycategory(String category) async {
    if (this.categoryArticles[category] != null &&
        this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co&category=$category');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);

    notifyListeners();
  }
}
