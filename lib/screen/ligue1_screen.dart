import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcdv_app/enum/app-enum.dart';

class Ligue1Page extends StatelessWidget {
  TypeStats typeStats;

  Ligue1Page(this.typeStats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          typeStats == TypeStats.classement
              ? "1ère Ligue - Classement"
              : "1ère Ligue - Matchs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
