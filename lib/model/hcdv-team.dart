enum HcdvTeam {
  Equipe1("1ère équipe", "105462"),
  U20("U20", "104914"),
  U17("U17", "104252"),
  U15("U15", "104056"),
  U13TOP("U13Top", "105237"),
  U13A("U13A", "104057"),
  NO_HCDV_TEAM("", "");

  final String libelle;
  final String gameCenterTeamId;

  const HcdvTeam(this.libelle, this.gameCenterTeamId);

/** Retourne la bonne équipe en fonction de l'id passé */
  static HcdvTeam resolveByTeamId(String teamId) {
    return HcdvTeam.values.firstWhere((team) {
      return team.gameCenterTeamId == teamId;
    }, orElse: () => HcdvTeam.NO_HCDV_TEAM);
  }
}
