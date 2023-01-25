import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/app-enum.dart';

class U13topLiguePage extends StatelessWidget {
  TypeStats typeStats;

  U13topLiguePage(this.typeStats);

  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          typeStats == TypeStats.classement
              ? "U13top - Classement"
              : "U13top - Matchs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
