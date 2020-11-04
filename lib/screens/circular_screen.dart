import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:svt_kallianpur/screens/pdf_view_screen.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CircularScreen extends StatefulWidget {
  static const routeName = "/circular";

  @override
  _CircularScreenState createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
  List circularList = [];
  bool isLoad = true;
  bool _initialized = false;
  bool _error = false;
  DateTime date = DateTime.now();
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getCirculars();
  }

  _getCirculars() async {
    final response = await http.post(
        "http://svtkallianpur.com/wp-content/php/getCirculars.php",
        body: {});
    final jsonRespone = json.decode(response.body);
    List allList = jsonRespone['circulars'].cast<Map<String, dynamic>>();
    print(allList);
    allList.map((e) {
      print(e["date"]);
      if (DateTime.parse(e["date"]).isAfter(DateTime.now())) {
        circularList.add(e);
      }
    }).toList();
    circularList.sort((a, b) =>
        DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));

    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF7F0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        title: Text(
          "Announcements",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (circularList.length != 0)
              ? Container(
                  child: ListView.builder(
                    itemCount: circularList.length,
                    itemBuilder: (context, index) {
                      DateTime _date =
                          DateTime.parse(circularList[index]["date"]);
                      return Card(
                          child: ListTile(
                        title: Text(circularList[index]["title"]),
                        subtitle: Text(DateFormat("dd-MM-yyyy").format(_date)),
                        trailing: Icon(
                          Icons.picture_as_pdf,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              PDFViewScreen.routeName,
                              arguments: circularList[index]["url"]);
                        },
                      ));
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'No Announcements yet',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
    );
  }
}
