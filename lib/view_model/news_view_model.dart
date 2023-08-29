
import 'package:news_app/models/news_channels_headlnes_model.dart';
import 'package:news_app/repository/news_repository.dart';

import '../models/catagories_news_model.dart';

class NewsViewModel{

  final _repo =NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadLinesApi(String channelName)async{
    final response = await _repo.newsChannelsHeadLinesApi(channelName);
    return response;
  }

  Future<CatagoriesNewsModel> fetchCatagoriesNewApi(String catagory)async{
    final response = await _repo.catagoriesNewsApi(catagory);
    return response;
  }

}