import 'package:flutter/material.dart';
import 'package:svt_kallianpur/data/sevaData.dart';

class SevaScreen extends StatelessWidget {
  static const routeName = "/seva";

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
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text("${SevaData.sevas[index]['name']}"),
              trailing: Text("${SevaData.sevas[index]['cost']}"),
            ));
          },
          itemCount: SevaData.sevas.length,
        ),
      ),
    );
  }
}
