import 'package:hcdv_app/model/type-match.dart';

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
