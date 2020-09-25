import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svt_kallianpur/data/urlData.dart';
import 'package:svt_kallianpur/screens/gallery_display_image_screen.dart';
import 'package:svt_kallianpur/widgets/loading.dart';

class GalleryDetailScreen extends StatefulWidget {
  static const routeName = "/galleryDetail";

  @override
  _GalleryDetailScreenState createState() => _GalleryDetailScreenState();
}

class _GalleryDetailScreenState extends State<GalleryDetailScreen> {
  bool _isLoad = true;
  List _galleryList = [];
  String name = "";
  String folderName = "";
  bool _check = false;

  getData() async {
    final response = await http.post(
        "http://svtkallianpur.com/wp-content/getGalleryPhotos.php",
        body: {"folder": "gallery/$folderName/"});
    final jsonResponse = json.decode(response.body);
    _galleryList = jsonResponse['images'];
    setState(() {
      _isLoad = false;
    });
  }

  String getImageUrl(int index) {
    return UrlData.galleryDetailUrl + _galleryList[index];
  }

  Widget galleryCard(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(GalleryDisplayImageScreen.routeName,
              arguments: [index, _galleryList, name]);
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
    final arg = ModalRoute.of(context).settings.arguments as List;

    if (!_check) {
      folderName = arg[0];
      name = arg[1];
      _check = true;
      getData();
    }

    return Scaffold(
      backgroundColor: Color(0xffFFF7F0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        title: Text(
          "$name",
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
