import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/news_channels_headlnes_model.dart';

import '../models/catagories_news_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> newsChannelsHeadLinesApi(String  channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=25d769bc88954cca96717d7e1f00585c';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('error');
    }
  }

  Future<CatagoriesNewsModel> catagoriesNewsApi(String catagory)async{
    String url = 'https://newsapi.org/v2/everything?q=${catagory}&apiKey=25d769bc88954cca96717d7e1f00585c';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final body = jsonDecode(response.body);
      return CatagoriesNewsModel.fromJson(body);
    }
    else{
      throw Exception('error');
    }
  }

}
