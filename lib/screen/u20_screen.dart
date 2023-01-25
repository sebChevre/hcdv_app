import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/app-enum.dart';

class U20LiguePage extends StatelessWidget {
  TypeStats typeStats;

  U20LiguePage(this.typeStats);

  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          typeStats == TypeStats.classement
              ? "U20 - Classement"
              : "U20 - Matchs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
