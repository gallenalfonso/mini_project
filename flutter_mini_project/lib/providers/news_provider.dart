import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/top_news_models.dart';
import 'package:flutter_mini_project/services/news_service.dart';
import 'package:flutter_mini_project/utils/urls.dart';

class NewsProvider with ChangeNotifier {
  bool isLoading = true;
  
  TopNewsModel? resNews;
  String url = Urls.baseUrlNews;
  String apiKey = Urls.apiKey;  

  Future getTopNews() async{
    //panggil api get news
    final res = await api('${url}top-headlines?country=us&category=business&apiKey=${apiKey}');

    if (res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
      
    }else {
      resNews = TopNewsModel();
    }
    isLoading = false;
   notifyListeners();
  }
}
