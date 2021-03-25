import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:svt_kallianpur/data/urlData.dart';
import 'package:svt_kallianpur/model/gallery.dart';

class GalleryDisplayImageScreen extends StatefulWidget {
  static const routeName = "/galleryDisplayImage";

  @override
  _GalleryDisplayImageScreenState createState() =>
      _GalleryDisplayImageScreenState();
}

class _GalleryDisplayImageScreenState extends State<GalleryDisplayImageScreen> {
  bool _check = false;
  Gallery gallery;
  int index = 0;
  PageController _controller;
  List<Photo> photos = [];
  String getImageUrl(int index) {
    String imgName = photos[index].filename;
    String folderName = gallery.path;
    return UrlData.galleryFolderUrl + folderName + imgName;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as List;
    if (!_check) {
      index = data[0];
      photos = data[1];
      gallery = data[2];
      _check = true;
      _controller = PageController(initialPage: index);
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
        body: PageView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            return Hero(
              tag: "${getImageUrl(index)}",
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(getImageUrl(index)),
              ),
            );
          },
          itemCount: photos.length,
        ));
  }
}
