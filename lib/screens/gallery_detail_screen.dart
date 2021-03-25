import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svt_kallianpur/data/urlData.dart';
import 'package:svt_kallianpur/model/gallery.dart';
import 'package:svt_kallianpur/screens/gallery_display_image_screen.dart';
import 'package:svt_kallianpur/widgets/loading.dart';

class GalleryDetailScreen extends StatefulWidget {
  static const routeName = "/galleryDetail";

  @override
  _GalleryDetailScreenState createState() => _GalleryDetailScreenState();
}

class _GalleryDetailScreenState extends State<GalleryDetailScreen> {
  bool _isLoad = true;
  List<Photo> photos = [];
  bool _check = false;
  Gallery gallery;

  getData() async {
    final response = await http.get(
      "http://svtkallianpur.com/wp-content/php/getWPPhotos.php?gid=${gallery.gid}",
    );
    final jsonResponse = json.decode(response.body);
    jsonResponse.map((e) => photos.add(Photo.fromJson(e))).toList();

    setState(() {
      _isLoad = false;
    });
  }

  String getImageUrl(int index) {
    String imgName = photos[index].filename;
    String folderName = gallery.path;
    return UrlData.galleryFolderUrl + folderName + imgName;
  }

  Widget galleryCard(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(GalleryDisplayImageScreen.routeName,
              arguments: [index, photos, gallery]);
        },
        child: Hero(
          tag: "${getImageUrl(index)}",
          child: CachedNetworkImage(
            imageUrl: getImageUrl(index),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gallery = ModalRoute.of(context).settings.arguments;

    if (!_check) {
      _check = true;
      getData();
    }

    return Scaffold(
      backgroundColor: Color(0xffFFF7F0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        title: Text(
          gallery.title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: _isLoad
          ? Loading()
          : Container(
              child: GridView.builder(
                  itemCount: photos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return galleryCard(index);
                  }),
            ),
    );
  }
}
