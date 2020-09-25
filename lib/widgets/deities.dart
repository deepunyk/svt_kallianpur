import 'package:flutter/material.dart';
import 'package:svt_kallianpur/data/deitiesData.dart';
import 'package:svt_kallianpur/screens/deities_detail_screen.dart';

class Deities extends StatelessWidget {
  deitiesCard(Map deitie, BuildContext context, int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DeitiesDetailScreen.routeName, arguments: index);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Hero(
                tag: "${deitie['title']}",
                child: Image.asset(
                  "${deitie['img']}",
                  height: 125,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deitie['title']}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${deitie['description']}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "Deities",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        deitiesCard(DeitiesData.deites[0], context, 0),
        deitiesCard(DeitiesData.deites[1], context, 1),
        deitiesCard(DeitiesData.deites[2], context, 2),
        deitiesCard(DeitiesData.deites[3], context, 3),
      ],
    );
  }
}
