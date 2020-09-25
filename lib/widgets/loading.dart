import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 50, width: 50, child: CircularProgressIndicator()),
          const SizedBox(
            height: 5,
          ),
          Text("Please wait"),
        ],
      ),
    );
  }
}
