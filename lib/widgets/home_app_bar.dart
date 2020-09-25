import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      bottom: PreferredSize(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Shri Venkataramana Temple",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Kallianpur",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(16),
      ),
      expandedHeight: _mediaQuery.height * 0.5,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset("assets/images/main_bck.jpg"),
      ),
    );
  }
}
