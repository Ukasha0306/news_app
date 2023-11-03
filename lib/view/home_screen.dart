import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channels_headlnes_model.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

import '../models/catagories_news_model.dart';

enum NewsFilterList { bbcNews, aryNews, independent, cnn, alJazeera, reuters }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsFilterList? selectedMenu;
  String name = 'bbc-news';

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              height: 25,
              width: 25,
            )),
        actions: [
          PopupMenuButton<NewsFilterList>(
            icon: const Icon(Icons.more_vert, color: Colors.black,),
            initialValue: selectedMenu,
            onSelected: (NewsFilterList item){
              if(NewsFilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(NewsFilterList.alJazeera.name == item.name){
                name = 'al-jazeera-english';
              }
              if(NewsFilterList.cnn.name == item.name){
                name = 'cnn';
              }
              if(NewsFilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(NewsFilterList.reuters.name == item.name){
                name = 'nbc-news';
              }
              if(NewsFilterList.independent.name == item.name){
                name = 'independent';
              }
              setState(() {
                selectedMenu = item;

              });
            },
            itemBuilder: (context)=> <PopupMenuEntry<NewsFilterList>>[
              const PopupMenuItem(
                value: NewsFilterList.bbcNews,
                  child: Text('BBC News'),),
              const PopupMenuItem(
                  value: NewsFilterList.alJazeera,
                  child: Text('alJazeera News'),),
              const PopupMenuItem(
                  value: NewsFilterList.cnn,
                  child: Text('CNN News'),),
              const PopupMenuItem(
                  value: NewsFilterList.aryNews,
                  child: Text('Ary News'),),
              const PopupMenuItem(
                  value: NewsFilterList.reuters,
                  child: Text('Reuters News'),),
              const PopupMenuItem(
                  value: NewsFilterList.independent,
                  child: Text('Independent News'),),


          ],
          ),
        ],
        title: Text(
          "News",
          style: GoogleFonts.acme(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadLinesApi(name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: SpinKitCircle(
                      color: Colors.deepPurple.shade200,
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewDetailsScreen(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                newsTitle: snapshot.data!.articles![index].title.toString(),
                                newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                author: snapshot.data!.articles![index].author.toString(),
                                description: snapshot.data!.articles![index].description.toString(),
                                content: snapshot.data!.articles![index].content.toString(),
                                source: snapshot.data!.articles![index].source!.name.toString()),),);
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * .40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: spinKit,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: height * 0.02,
                                  left: height * 0.02,
                                  right: height * 0.02,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20,),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(width * 0.02,),
                                        alignment: Alignment.bottomCenter,
                                        height: height * .25,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              color: Colors.black26,
                                              width: width * 0.4,
                                              child: Text(
                                                snapshot.data!.articles![index].title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.adamina(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: width * 0.4,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      snapshot.data!.articles![index]
                                                          .source!.name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.adamina(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.adamina(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<CatagoriesNewsModel>(
              future: newsViewModel.fetchCatagoriesNewApi('general'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.deepPurple.shade200,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * 0.25,
                                width : width * 0.20,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                    child: SpinKitCircle(
                                      color: Colors.deepPurple.shade200,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * 0.18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.articles![index].title.toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                        Flexible( 
                                          child: Text(format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

SpinKitFadingCircle spinKit = SpinKitFadingCircle(
  color: Colors.deepPurple.shade200,
  size: 50,
);
