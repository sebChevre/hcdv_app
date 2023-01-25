import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcdv_app/enum/app-enum.dart';

class CoupePage extends StatelessWidget {
  const CoupePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Text(
          "Coupe Suisse",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
