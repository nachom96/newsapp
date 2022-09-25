import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = 'b59a8bb2f7fb48f4836cd4cd842e65d0';

class NewsService with ChangeNotifier{
  
  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ]; 

  Map<String, List<Article>> categoryArticles = {
     
  };

  NewsService() {
    getTopHeadlines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
     });
  } 

  get selectedCategory => _selectedCategory;
  set selectedCategorySet ( String valor ){
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List <Article> get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory] as List<Article>;


  getTopHeadlines() async{
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

  getArticlesByCategory( String category ) async{

    if (categoryArticles[category]!.length > 0){
      return categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll( newsResponse.articles );
    notifyListeners();
  }


}