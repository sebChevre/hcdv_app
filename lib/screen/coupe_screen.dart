import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoupePage extends StatelessWidget {
  const CoupePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        const Text(
          "Coupe Suisse",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
