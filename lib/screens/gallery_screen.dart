import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svt_kallianpur/data/urlData.dart';
import 'package:svt_kallianpur/screens/gallery_detail_screen.dart';
import 'package:svt_kallianpur/widgets/loading.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = "/gallery";

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _isLoad = true;
  List _galleryList = [];

  getData() async {
    final response = await http
        .get("http://svtkallianpur.com/wp-content/getGalleryFolders.php");
    final jsonResponse = json.decode(response.body);
    _galleryList = jsonResponse['gallery'];
    setState(() {
      _isLoad = false;
    });
  }

  String getImageUrl(int index) {
    String imgName = _galleryList[index]['prev_image'];
    String folderName = _galleryList[index]['folder_name'];
    return UrlData.galleryFolderUrl + folderName + "/" + imgName;
  }

  Widget galleryCard(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(GalleryDetailScreen.routeName,
              arguments: [
                _galleryList[index]['folder_name'],
                _galleryList[index]['name']
              ]);
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
                "${_galleryList[index]['name']}",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
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
        title: Text(
          "Gallery",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: _isLoad
          ? Loading()
          : Container(
              child: GridView.builder(
                  itemCount: _galleryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return galleryCard(index);
                  }),
            ),
    );
  }
}
