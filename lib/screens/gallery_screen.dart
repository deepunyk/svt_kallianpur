import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svt_kallianpur/data/urlData.dart';
import 'package:svt_kallianpur/model/gallery.dart';
import 'package:svt_kallianpur/screens/gallery_detail_screen.dart';
import 'package:svt_kallianpur/widgets/loading.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = "/gallery";

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _isLoad = true;
  List<Gallery> galleries = [];
  List<Gallery> filteredGallery = [];
  bool isSearch = false;

  getData() async {
    final response = await http
        .get("http://svtkallianpur.com/wp-content/php/getWPGallery.php");
    final jsonResponse = json.decode(response.body);
    jsonResponse.map((e) => galleries.add(Gallery.fromJson(e))).toList();
    filteredGallery = [...galleries];
    setState(() {
      _isLoad = false;
    });
  }

  String getImageUrl(int index) {
    String imgName = galleries[index].filename;
    String folderName = galleries[index].path;
    return UrlData.galleryFolderUrl + folderName + imgName;
  }

  Widget galleryCard(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(GalleryDetailScreen.routeName,
              arguments: filteredGallery[index]);
        },
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: getImageUrl(index),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                "${filteredGallery[index].title}",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  filterGallery(String val) {
    print(galleries.length);
    print(filteredGallery.length);
    filteredGallery.clear();
    galleries.map((e) {
      String title = e.title.toLowerCase();
      val = val.toLowerCase();
      print(title);
      if (title.contains(val)) {
        filteredGallery.add(e);
      }
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF7F0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        title: isSearch
            ? Container(
                child: TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter event name"),
                  autofocus: true,
                  onChanged: (val) {
                    filterGallery(val);
                  },
                ),
              )
            : Text(
                "Gallery",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
        actions: [
          !isSearch
              ? InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    isSearch = true;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.search,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    filterGallery('');
                    isSearch = false;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
        ],
      ),
      body: _isLoad
          ? Loading()
          : Container(
              child: GridView.builder(
                  itemCount: filteredGallery.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return galleryCard(index);
                  }),
            ),
    );
  }
}
