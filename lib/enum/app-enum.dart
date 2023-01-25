enum TypeMatch {
  championnat("Championnat"),
  coupe("Coupe Suisse");

  final String label;

  const TypeMatch(this.label);
}

enum Ligue {
  ligue1("1ère ligue"),
  u20("U-20"),
  u17("U-17"),
  u15("U-15"),
  u13top("U-13 Top"),
  u13a("U-13 A");

  final String label;

  const Ligue(this.label);
}

enum TypeStats {
  matchs("Matchs"),
  classement("Classement");

  final String label;

  const TypeStats(this.label);
}
