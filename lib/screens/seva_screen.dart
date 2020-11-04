import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SevaScreen extends StatefulWidget {
  static const routeName = "/seva";

  @override
  _SevaScreenState createState() => _SevaScreenState();
}

class _SevaScreenState extends State<SevaScreen> {
  List sevaList = [];
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    _getSevas();
  }

  _getSevas() async {
    final response = await http
        .post("http://svtkallianpur.com/wp-content/php/getSevas.php", body: {});
    final jsonRespone = json.decode(response.body);
    sevaList = jsonRespone['sevas'].cast<Map<String, dynamic>>();
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
          "Seva Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        child: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: sevaList.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(sevaList[index]["name"]),
                    trailing: Text('₹' +
                        int.parse(sevaList[index]["cost"]).toStringAsFixed(2)),
                  ));
                },
              ),
      ),
    );
  }
}
