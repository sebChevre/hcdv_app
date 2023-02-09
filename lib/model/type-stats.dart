import 'package:flutter/material.dart';

enum TypeStats {
  matchs("Matchs", Icon(Icons.sports_hockey_outlined)),
  classement("Classement", Icon(Icons.table_rows));

  final String label;
  final Icon icon;

  const TypeStats(this.label, this.icon);
}
