import 'package:flutter/material.dart';
import 'package:svt_kallianpur/data/deitiesData.dart';

class DeitiesDetailScreen extends StatefulWidget {
  static const routeName = "/deities";

  @override
  _DeitiesDetailScreenState createState() => _DeitiesDetailScreenState();
}

class _DeitiesDetailScreenState extends State<DeitiesDetailScreen> {
  PageController _controller;
  bool check = false;

  Widget deitiesWidget(int index, BuildContext context, double width) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "${DeitiesData.deites[index]["title"]}",
              child: Image.asset(
                "${DeitiesData.deites[index]["img"]}",
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "${DeitiesData.deites[index]["title"]}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 16),
              child: Text(
                "${DeitiesData.deites[index]["description"]}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "${DeitiesData.deites[index]["para"]}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    if (!check) {
      check = true;
      int page = ModalRoute.of(context).settings.arguments;
      _controller = PageController(initialPage: page);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        title: Text(
          "Deities",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          _controller.page == 3
              ? _controller.animateToPage(0,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn)
              : _controller.nextPage(
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        },
      ),
      body: PageView(
        controller: _controller,
        children: [
          deitiesWidget(0, context, _mediaQuery.width),
          deitiesWidget(1, context, _mediaQuery.width),
          deitiesWidget(2, context, _mediaQuery.width),
          deitiesWidget(3, context, _mediaQuery.width),
        ],
      ),
    );
  }
}
