import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'newsapi.org';
final _API_KEY = 'bf288bb628e64c05aabaedec3db2829f';
final _PAIS = 'ca';

class NewsService with ChangeNotifier {

  List<Article> headLines = [];

  String _selectedCategory = 'business';
  
  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertaiment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyball, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      List<Article> articles = [];
      this.categoryArticles[item.name] = articles;
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = Uri.https(_URL_NEWS, 'v2/top-headlines', {
      'apiKey': _API_KEY,
      'country': _PAIS
    });

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headLines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.https(_URL_NEWS, 'v2/top-headlines', {
      'apiKey': _API_KEY,
      'country': _PAIS,
      'category': category
    });

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);

    notifyListeners();
  }

}