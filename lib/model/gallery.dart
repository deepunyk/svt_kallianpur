class Photo {
  Photo({
    this.pid,
    this.imageSlug,
    this.postId,
    this.galleryid,
    this.filename,
    this.description,
    this.alttext,
    this.imagedate,
    this.exclude,
    this.sortorder,
    this.metaData,
    this.extrasPostId,
    this.updatedAt,
  });

  String pid;
  String imageSlug;
  String postId;
  String galleryid;
  String filename;
  String description;
  String alttext;
  DateTime imagedate;
  String exclude;
  String sortorder;
  String metaData;
  String extrasPostId;
  String updatedAt;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        pid: json["pid"],
        imageSlug: json["image_slug"],
        postId: json["post_id"],
        galleryid: json["galleryid"],
        filename: json["filename"],
        description: json["description"],
        alttext: json["alttext"],
        imagedate: DateTime.parse(json["imagedate"]),
        exclude: json["exclude"],
        sortorder: json["sortorder"],
        metaData: json["meta_data"],
        extrasPostId: json["extras_post_id"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "image_slug": imageSlug,
        "post_id": postId,
        "galleryid": galleryid,
        "filename": filename,
        "description": description,
        "alttext": alttext,
        "imagedate": imagedate.toIso8601String(),
        "exclude": exclude,
        "sortorder": sortorder,
        "meta_data": metaData,
        "extras_post_id": extrasPostId,
        "updated_at": updatedAt,
      };
}

class Gallery {
  Gallery(
      {this.gid,
      this.name,
      this.slug,
      this.path,
      this.title,
      this.galdesc,
      this.pageid,
      this.previewpic,
      this.author,
      this.extrasPostId,
      this.filename});

  String gid;
  String name;
  String slug;
  String path;
  String title;
  String galdesc;
  String pageid;
  String previewpic;
  String author;
  String extrasPostId;
  String filename;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        gid: json["gid"],
        name: json["name"],
        slug: json["slug"],
        path: json["path"],
        title: json["title"],
        galdesc: json["galdesc"] == null ? null : json["galdesc"],
        pageid: json["pageid"],
        previewpic: json["previewpic"],
        author: json["author"],
        extrasPostId: json["extras_post_id"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "gid": gid,
        "name": name,
        "slug": slug,
        "path": path,
        "title": title,
        "galdesc": galdesc == null ? null : galdesc,
        "pageid": pageid,
        "previewpic": previewpic,
        "author": author,
        "extras_post_id": extrasPostId,
      };
}
