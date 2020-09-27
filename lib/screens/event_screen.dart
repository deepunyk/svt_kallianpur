import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/event";

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List eventList = [];
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  _getEvents() async {
    final response = await http.post(
        "http://svtkallianpur.com/wp-content/php/getEvents.php", body: {
    });
    final jsonRespone = json.decode(response.body);
    eventList = jsonRespone['events'].cast<Map<String, dynamic>>();
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
          "Event Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        child: isLoad ? Center(child: CircularProgressIndicator(),):ListView.builder(
          itemCount: eventList.length,
          itemBuilder: (context, index) {
            DateTime _date = DateTime.parse(eventList[index]["date"]);
            return Card(
                child: ListTile(
                  title: Text(eventList[index]["name"]),
                  trailing: Text(DateFormat("dd-MM-yyyy").format(_date)),
                  subtitle: Text(DateFormat("h:mm a").format(_date)),
                ));
          },
        ),
      ),
    );
  }
}
