import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enum/app-enum.dart';

class U17LiguePage extends StatelessWidget {
  TypeStats typeStats;

  U17LiguePage(this.typeStats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          typeStats == TypeStats.classement
              ? "U17 - Classement"
              : "U17 - Matchs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
