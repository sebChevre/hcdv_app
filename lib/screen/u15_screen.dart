import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/app-enum.dart';

class U15LiguePage extends StatelessWidget {
  TypeStats typeStats;

  U15LiguePage(this.typeStats);

  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          typeStats == TypeStats.classement
              ? "U15 - Classement"
              : "U15 - Matchs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
