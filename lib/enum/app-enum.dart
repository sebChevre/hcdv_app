import 'package:flutter/material.dart';

enum TypeMatch {
  championnat("Championnat", "champion.png"),
  playoff("Playoff/Playout", "playoff.png"),
  coupe("Coupe Suisse", "cup.png");

  final String label;
  final String image;

  const TypeMatch(this.label, this.image);
}

enum Ligue {
  ligue1("1ère équipe", [TypeMatch.championnat, TypeMatch.playoff]),
  u20("U-20", [TypeMatch.championnat, TypeMatch.playoff]),
  u17("U-17", [TypeMatch.championnat, TypeMatch.playoff]),
  u15("U-15", [TypeMatch.championnat, TypeMatch.playoff]),
  u13top("U-13 Top", [TypeMatch.championnat, TypeMatch.playoff]),
  u13a("U-13 A", [TypeMatch.championnat, TypeMatch.playoff]);

  final String label;
  final List<TypeMatch> typesMatch;

  const Ligue(this.label, this.typesMatch);
}

enum TypeStats {
  matchs("Matchs", Icon(Icons.sports_hockey_outlined)),
  classement("Classement", Icon(Icons.table_rows));

  final String label;
  final Icon icon;

  const TypeStats(this.label, this.icon);
}

enum AppColor {
  main_red(Color.fromARGB(255, 206, 39, 27));

  const AppColor(this.color);

  final Color color;
}
