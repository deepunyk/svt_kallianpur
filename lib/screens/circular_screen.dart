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
    circularList = jsonRespone['circulars'].cast<Map<String, dynamic>>();
    setState(() {
      isLoad = false;
      for (int i = 0; i < circularList.length; i++) {
        var today_date = int.parse(
            DateFormat("d").format(DateTime.parse(circularList[i]["date"])));
        var today_month = int.parse(
            DateFormat("M").format(DateTime.parse(circularList[i]["date"])));
        var today_year = int.parse(
            DateFormat("y").format(DateTime.parse(circularList[i]["date"])));
        if (DateTime(today_year, today_month, today_date)
                .difference(DateTime(date.year, date.month, date.day))
                .inDays >=
            0) {
          count++;
        }
      }
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
          : (count != 0)
              ? Container(
                  child: ListView.builder(
                    itemCount: count,
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
