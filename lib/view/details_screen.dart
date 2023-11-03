import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      description,
      newDates,
      author,
      content,
      source;
  const DetailsScreen(
      {Key? key,
      required this.newsImage,
      required this.newsTitle,
      required this.description,
      required this.newDates,
      required this.author,
      required this.content,
      required this.source})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    DateTime dateTime = DateTime.parse(widget.newDates);
    return Scaffold(
      appBar: AppBar(
        title:  Text("Details Screen", style: GoogleFonts.poppins(fontSize: 20),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.45,
            child: CachedNetworkImage(
              imageUrl: widget.newsImage,
              fit: BoxFit.cover,
              placeholder: (context, ulr) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
            ),
            height: height * 0.60,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            margin: EdgeInsets.only(top: height * 0.40),
            child: ListView(
              children: [
                Text(
                  widget.newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
