import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/model/groupe-match.dart';
import 'package:hcdv_app/model/hcdv-team.dart';
import 'package:xml/xml.dart';

import 'detailled-score.dart';

class Game {
  Game(
      {required this.groupe,
      this.gameId,
      this.guideNumber,
      required this.homeTeamId,
      this.homeTeamName,
      required this.awayTeamId,
      this.awayTeamName,
      this.arena,
      required this.date,
      this.begin,
      required this.beginDateTime,
      this.end,
      this.homeScore,
      this.awayScore,
      this.thirdsResults,
      this.homePoints,
      this.awayPoints,
      this.overtime,
      this.overtimes,
      this.decisionType,
      this.status,
      this.statusSymbol,
      this.spectators,
      this.refereeName,
      this.referee2Name,
      this.xmlns,
      required this.leagueId,
      required this.detailedScore});
  GroupeMatch? groupe; //last, today, next
  String? gameId;
  String? guideNumber;
  String homeTeamId;
  String? homeTeamName;
  String awayTeamId;
  String? awayTeamName;
  String? arena;
  DateTime date;
  String? begin;
  DateTime beginDateTime;
  String? end;
  String? homeScore;
  String? awayScore;
  String? thirdsResults;
  String? homePoints;
  String? awayPoints;
  String? overtime;
  String? overtimes;
  String? decisionType;
  String? status;
  String? statusSymbol;
  String? spectators;
  String? refereeName;
  String? referee2Name;
  String? xmlns;
  String leagueId;
  DetailedScore detailedScore;

  bool isHCDVHomeTeam(String teamId) {
    HcdvTeam team = HcdvTeam.resolveByTeamId(teamId);

    if (team == HcdvTeam.NO_HCDV_TEAM) {
      return false;
    }
    return teamId == homeTeamId;
  }

  bool isHCDVWinnerTeam(String homeTeamId) {
    return isHCDVHomeTeam(homeTeamId)
        ? int.parse(homeScore!) > int.parse(awayScore!)
        : int.parse(awayScore!) > int.parse(homeScore!);
  }

  factory Game.fromXmlElement(
          String leagueId, GroupeMatch groupe, XmlElement xmlElement) =>
      Game(
          groupe: groupe,
          gameId: xmlElement.findElements("GameID").first.text,
          guideNumber: xmlElement.findElements("GuideNumber").first.text,
          homeTeamId: xmlElement.findElements("HomeTeamID").first.text,
          homeTeamName: xmlElement.findElements("HomeTeamName").first.text,
          awayTeamId: xmlElement.findElements("AwayTeamID").first.text,
          awayTeamName: xmlElement.findElements("AwayTeamName").first.text,
          arena: xmlElement.findElements("Arena").first.text,
          date: DateTime.parse(
              xmlElement.findElements("Date").first.text.replaceAll(".", "-")),
          begin: xmlElement.findElements("Begin").first.text,
          beginDateTime: DateTime.parse(
              '${xmlElement.findElements("Date").first.text.replaceAll(".", "-")} ${xmlElement.findElements("Begin").first.text}'),
          end: xmlElement.findElements("End").first.text,
          homeScore: xmlElement.findElements("HomeScore").first.text,
          awayScore: xmlElement.findElements("AwayScore").first.text,
          thirdsResults: xmlElement.findElements("ThirdsResults").first.text,
          homePoints: xmlElement.findElements("HomePoints").first.text,
          awayPoints: xmlElement.findElements("AwayPoints").first.text,
          overtime: xmlElement.findElements("Overtime").first.text,
          overtimes: xmlElement.findElements("Overtimes").first.text,
          decisionType: xmlElement.findElements("DecisionType").first.text,
          status: xmlElement.findElements("Status").first.text,
          statusSymbol: xmlElement.findElements("StatusSymbol").first.text,
          spectators: xmlElement.findElements("Spectators").first.text,
          refereeName: xmlElement.findElements("RefereeName").first.text,
          referee2Name: xmlElement.findElements("Referee2Name").first.text,
          leagueId: leagueId,
          detailedScore: DetailedScore(
              xmlElement.findElements("ThirdsResults").first.text,
              xmlElement.findElements("DecisionType").first.text,
              xmlElement.findElements("Status").first.text));
}
