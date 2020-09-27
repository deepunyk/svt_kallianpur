import 'package:flutter/material.dart';
import 'package:svt_kallianpur/screens/circular_screen.dart';
import 'package:svt_kallianpur/screens/event_screen.dart';
import 'package:svt_kallianpur/screens/gallery_screen.dart';
import 'package:svt_kallianpur/screens/seva_screen.dart';
import 'package:svt_kallianpur/widgets/contact.dart';
import 'package:svt_kallianpur/widgets/deities.dart';

class HomeBody extends StatelessWidget {
  topCardWidget(
      String title, IconData iconData, Function onTap, BuildContext context) {
    return Flexible(
      flex: 1,
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Icon(iconData)],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  topCardWidget("Gallery", Icons.image, () {
                    Navigator.of(context).pushNamed(GalleryScreen.routeName);
                  }, context),
                  const SizedBox(
                    width: 16,
                  ),
                  topCardWidget("Seva List", Icons.list, () {
                    Navigator.of(context).pushNamed(SevaScreen.routeName);
                  }, context),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    topCardWidget("Events", Icons.event_available, () {
                      Navigator.of(context).pushNamed(EventScreen.routeName);
                    }, context),
                    const SizedBox(
                      width: 16,
                    ),
                    topCardWidget("Circulars", Icons.note, () {
                      Navigator.of(context).pushNamed(CircularScreen.routeName);
                    }, context),
                  ],
                ),
              ),
            ],
          ),
        ),
        Deities(),
        Contact()
      ]),
    );
  }
}
