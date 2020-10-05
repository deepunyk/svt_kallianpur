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
  DateTime date =DateTime.now();
  int count=0;

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
      for(int i=0;i<eventList.length;i++){
        var today_date=int.parse(DateFormat("d").format(DateTime.parse(eventList[i]["date"])));
        var today_month=int.parse(DateFormat("M").format(DateTime.parse(eventList[i]["date"])));
        var today_year=int.parse(DateFormat("y").format(DateTime.parse(eventList[i]["date"])));
        if(DateTime(today_year, today_month, today_date).difference(DateTime(date.year, date.month, date.day)).inDays >= 0){
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
          "Event Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: (count!=0)?Container(
        child: isLoad ? Center(child: CircularProgressIndicator(),):ListView.builder(
          itemCount: count,
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
      ):Center(child: Text('No Events yet',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25),),),
    );
  }
}
