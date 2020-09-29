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

  @override
  void initState() {
    super.initState();
    _getCirculars();
  }

  _getCirculars() async {
    final response = await http.post(
        "http://svtkallianpur.com/wp-content/php/getCirculars.php", body: {
    });
    final jsonRespone = json.decode(response.body);
    circularList = jsonRespone['circulars'].cast<Map<String, dynamic>>();
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
          "Circular Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        child: isLoad ? Center(child: CircularProgressIndicator(),):ListView.builder(
          itemCount: circularList.length,
          itemBuilder: (context, index) {
            DateTime _date = DateTime.parse(circularList[index]["date"]);
            return Card(
                child: ListTile(
                  title: Text(circularList[index]["title"]),
                  subtitle: Text(DateFormat("dd-MM-yyyy").format(_date)),
                  trailing: Icon(Icons.picture_as_pdf,color: Theme.of(context).primaryColor,),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PDFViewScreen.routeName, arguments: circularList[index]["url"]);
                  },
                ));
          },
        ),
      ),
    );
  }
}
