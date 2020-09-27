import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:svt_kallianpur/screens/pdf_view_screen.dart';

class CircularScreen extends StatefulWidget {
  static const routeName = "/circular";

  @override
  _CircularScreenState createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
  List circularList = [];
  bool isLoad = true;

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
            return Card(
                child: ListTile(
                  title: Text(circularList[index]["title"]),
                  subtitle: Text(circularList[index]["description"]),
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
