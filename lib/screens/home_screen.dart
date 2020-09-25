import 'package:flutter/material.dart';
import 'package:svt_kallianpur/widgets/home_app_bar.dart';
import 'package:svt_kallianpur/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF7F0),
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
          HomeBody(),
        ],
      ),
    );
  }
}
