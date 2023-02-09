enum TypeMatch {
  championnat("Championnat", "champion.png"),
  playoff("Playoff/Playout", "playoff.png"),
  coupe("Coupe Suisse", "cup.png");

  final String label;
  final String image;

  const TypeMatch(this.label, this.image);
}
