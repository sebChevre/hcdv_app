import 'package:hcdv_app/model/hcdv-team.dart';
import 'package:xml/xml.dart';

class Team {
  Team(
      {this.pos,
      this.teamId,
      this.teamName,
      this.games,
      this.gamesWon,
      this.gamesWonOvertime,
      this.gamesWonPenalty,
      this.gamesWonExtraTime,
      this.gamesWonInTime,
      this.gamesLost,
      this.gamesLostOvertime,
      this.gamesLostPenalty,
      this.gamesLostExtraTime,
      this.gamesLostInTime,
      this.gamesTied,
      this.goalsFor,
      this.goalsAgainst,
      this.goalsDifference,
      this.goalsOutwards,
      this.points,
      this.sog,
      this.streak,
      required this.leagueId,
      required this.hcdvTeam});

  String? pos;
  String? teamId;
  String? teamName;
  String? games;
  String? gamesWon;
  String? gamesWonOvertime;
  String? gamesWonPenalty;
  String? gamesWonExtraTime;
  String? gamesWonInTime;
  String? gamesLost;
  String? gamesLostOvertime;
  String? gamesLostPenalty;
  String? gamesLostExtraTime;
  String? gamesLostInTime;
  String? gamesTied;
  String? goalsFor;
  String? goalsAgainst;
  String? goalsDifference;
  String? goalsOutwards;
  String? points;
  String? sog;
  String? streak;
  String leagueId;
  HcdvTeam hcdvTeam;

  /** Equipe HCDV selon enum */
  bool isHCVDTeam(int leagueId) {
    return hcdvTeam != HcdvTeam.NO_HCDV_TEAM;
  }

  factory Team.fromXmlElement(String leagueId, XmlElement xmlElement) => Team(
      pos: xmlElement.findElements("Pos").first.text,
      teamId: xmlElement.findElements("TeamID").first.text,
      teamName: xmlElement.findElements("TeamName").first.text,
      games: xmlElement.findElements("Games").first.text,
      gamesWon: xmlElement.findElements("GamesWon").first.text,
      gamesWonOvertime: xmlElement.findElements("GamesWonOvertime").first.text,
      gamesWonPenalty: xmlElement.findElements("GamesWonPenalty").first.text,
      gamesWonExtraTime:
          xmlElement.findElements("GamesWonExtraTime").first.text,
      gamesWonInTime: xmlElement.findElements("GamesWonInTime").first.text,
      gamesLost: xmlElement.findElements("GamesLost").first.text,
      gamesLostOvertime:
          xmlElement.findElements("GamesLostOvertime").first.text,
      gamesLostPenalty: xmlElement.findElements("GamesLostPenalty").first.text,
      gamesLostExtraTime:
          xmlElement.findElements("GamesLostExtraTime").first.text,
      gamesLostInTime: xmlElement.findElements("GamesLostInTime").first.text,
      gamesTied: xmlElement.findElements("GamesTied").first.text,
      goalsFor: xmlElement.findElements("GoalsFor").first.text,
      goalsAgainst: xmlElement.findElements("GoalsAgainst").first.text,
      goalsDifference: xmlElement.findElements("GoalsDifference").first.text,
      goalsOutwards: xmlElement.findElements("GoalsOutwards").first.text,
      points: xmlElement.findElements("Points").first.text,
      sog: xmlElement.findElements("Sog").first.text,
      streak: xmlElement.findElements("Streak").first.text,
      leagueId: leagueId,
      hcdvTeam: HcdvTeam.resolveByTeamId(
          xmlElement.findElements("TeamID").first.text));
}
