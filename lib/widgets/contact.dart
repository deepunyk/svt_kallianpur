import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  socialMediaIcon(
      String url, IconData iconData, BuildContext context, Color color) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          iconData,
          size: 40,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            "Follow Us",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialMediaIcon(
                  "https://www.facebook.com/people/Shri-Venkataramana-Temple-Kallianpur/100009040469202",
                  MdiIcons.facebook,
                  context,
                  Colors.blue),
              socialMediaIcon(
                  "https://instagram.com/venkataraman_temple_kallianpur?igshid=1xhdzvxivtyaj",
                  MdiIcons.instagram,
                  context,
                  Color(0xffE1306C)),
              socialMediaIcon(
                  "https://www.youtube.com/channel/UC_A5WODdHIv5w-Z7318X9RQ",
                  MdiIcons.youtube,
                  context,
                  Colors.red),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
