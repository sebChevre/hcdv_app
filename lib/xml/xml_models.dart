import 'package:xml/xml.dart';

const int HCDV_TEAM_ID = 105462;
const int HCDV_LEAGUE_ID = 3;
const int HCDV_U20_TEAM_ID = 104914;
const int HCDV_U20_LEAGUE_ID = 105;
const int HCDV_U17_TEAM_ID = 104252;
const int HCDV_U17_LEAGUE_ID = 25;
const int HCDV_U15_TEAM_ID = 104056;
const int HCDV_U15_LEAGUE_ID = 107;
const int HCDV_U13TOP_TEAM_ID = 105237;
const int HCDV_U13TOP_LEAGUE_ID = 31;
const int HCDV_U13A_TEAM_ID = 104057;
const int HCDV_U13A_LEAGUE_ID = 32;

class Result {
  Result({
    required this.parameter,
    required this.games,
    required this.group,
  });

  final Parameter parameter;
  final List<Game> games;
  final String group;
}

class DetailedScore {
  int homeFirstTierGoal = 0;
  int awayFirstTierGoal = 0;
  int homeSecondTierGoal = 0;
  int awaySecondTierGoal = 0;
  int homeThirdTierGoal = 0;
  int awayThirdTierGoal = 0;
  int? homeExtraTimeGoal;
  int? awayExtraTimeGoal;
  String thirdResults;
  String decisionType;
  String status;

  DetailedScore(this.thirdResults, this.decisionType, this.status) {
    if (status != "18" && status != "0") {
      List<String> periods = thirdResults.split(",");

      homeFirstTierGoal = int.parse(periods[0].split(":")[0]);
      awayFirstTierGoal = int.parse(periods[0].split(":")[1]);

      homeSecondTierGoal = int.parse(periods[1].split(":")[0]);
      awaySecondTierGoal = int.parse(periods[1].split(":")[1]);

      homeThirdTierGoal = int.parse(periods[2].split(":")[0]);
      awayThirdTierGoal = int.parse(periods[2].split(":")[1]);

      if (decisionType == "2") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal =
            int.parse(periods[3].split(":")[1].replaceAll("[+1]", ""));
      }

      if (decisionType == "3") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal =
            int.parse(periods[3].split(":")[1].replaceAll("[p]", ""));
      }

      if (decisionType == "4") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal = int.parse(periods[3]
            .split(":")[1]
            .replaceAll("[+1", "")
            .replaceAll(",p]", ""));
      }
    }
  }
}

class Game {
  Game(
      {this.group,
      this.gameId,
      this.guideNumber,
      this.homeTeamId,
      this.homeTeamName,
      this.awayTeamId,
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

  String? group; //last, today, next
  String? gameId;
  String? guideNumber;
  String? homeTeamId;
  String? homeTeamName;
  String? awayTeamId;
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

  bool isHCDVHomeTeam(int leagueId) {
    switch (leagueId) {
      case HCDV_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_TEAM_ID;

      case HCDV_U20_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_U20_TEAM_ID;

      case HCDV_U17_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_U17_TEAM_ID;

      case HCDV_U15_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_U15_TEAM_ID;

      case HCDV_U13TOP_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_U13TOP_TEAM_ID;

      case HCDV_U13A_LEAGUE_ID:
        return int.parse(homeTeamId!) == HCDV_U13A_TEAM_ID;

      default:
        throw Exception(
            "[isHCDVHomeTeam] Case doesn't match leagueId: ${leagueId}");
    }
  }

  bool isHCDVWinnerTeam(int leagueId) {
    return isHCDVHomeTeam(leagueId)
        ? int.parse(homeScore!) > int.parse(awayScore!)
        : int.parse(awayScore!) > int.parse(homeScore!);
  }

  factory Game.fromXmlElement(
          String leagueId, String group, XmlElement xmlElement) =>
      Game(
          group: group,
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

class Parameter {
  Parameter({
    this.season,
    this.lastDate,
    required this.leagueId,
    this.leagueName,
    this.leagueNameF,
    this.leagueNameI,
    this.regionId,
    this.regionName,
    this.regionNameF,
    this.regionNameI,
    this.groupId,
    this.groupName,
    this.groupNameF,
    this.groupNameI,
    this.tournamentId,
    this.tournamentName,
    this.tournamentNameF,
    this.tournamentNameI,
    this.qualificationId,
    this.qualificationName,
    this.qualificationNameF,
    this.qualificationNameI,
    this.phaseId,
    this.phaseName,
    this.phaseNameF,
    this.phaseNameI,
    this.nofGames,
    this.durationThird,
    this.durationOvertime,
    this.regularPeriods,
    this.nofOvertimes,
    this.withTie,
    this.teamId,
    this.teamName,
  });

  String? season;
  DateTime? lastDate;
  String leagueId;
  String? leagueName;
  String? leagueNameF;
  String? leagueNameI;
  String? regionId;
  String? regionName;
  String? regionNameF;
  String? regionNameI;
  String? groupId;
  String? groupName;
  String? groupNameF;
  String? groupNameI;
  String? tournamentId;
  String? tournamentName;
  String? tournamentNameF;
  String? tournamentNameI;
  String? qualificationId;
  String? qualificationName;
  String? qualificationNameF;
  String? qualificationNameI;
  String? phaseId;
  String? phaseName;
  String? phaseNameF;
  String? phaseNameI;
  String? nofGames;
  String? durationThird;
  String? durationOvertime;
  String? regularPeriods;
  String? nofOvertimes;
  String? withTie;
  String? teamId;
  String? teamName;

  factory Parameter.fromXmlElement(XmlElement xmlElement) => Parameter(
        season: xmlElement.findElements("Season").first.text,
        lastDate: DateTime.parse(xmlElement
            .findElements("LastDate")
            .first
            .text
            .replaceAll(".", "-")),
        leagueId: xmlElement.findElements("LeagueID").single.text,
        leagueName: xmlElement.findElements("LeagueName").first.text,
        leagueNameI: xmlElement.findElements("LeagueNameI").first.text,
        leagueNameF: xmlElement.findElements("LeagueNameF").first.text,
        regionId: xmlElement.findElements("RegionID").first.text,
        regionName: xmlElement.findElements("RegionName").first.text,
        regionNameF: xmlElement.findElements("RegionNameF").first.text,
        regionNameI: xmlElement.findElements("RegionNameI").first.text,
        groupId: xmlElement.findElements("GroupID").first.text,
        groupName: xmlElement.findElements("GroupName").first.text,
        groupNameF: xmlElement.findElements("GroupNameF").first.text,
        groupNameI: xmlElement.findElements("GroupNameI").first.text,
        tournamentId: xmlElement.findElements("TournamentID").first.text,
        tournamentName: xmlElement.findElements("TournamentName").first.text,
        tournamentNameF: xmlElement.findElements("TournamentNameF").first.text,
        tournamentNameI: xmlElement.findElements("TournamentNameI").first.text,
        qualificationId: xmlElement.findElements("QualificationID").first.text,
        qualificationName:
            xmlElement.findElements("QualificationName").first.text,
        qualificationNameF:
            xmlElement.findElements("QualificationNameF").first.text,
        qualificationNameI:
            xmlElement.findElements("QualificationNameI").first.text,
        phaseId: xmlElement.findElements("PhaseID").first.text,
        phaseName: xmlElement.findElements("PhaseName").first.text,
        phaseNameF: xmlElement.findElements("PhaseNameF").first.text,
        phaseNameI: xmlElement.findElements("PhaseNameI").first.text,
        nofGames: xmlElement.findElements("NofGames").first.text,
        durationThird: xmlElement.findElements("DurationThird").first.text,
        durationOvertime:
            xmlElement.findElements("DurationOvertime").first.text,
        regularPeriods: xmlElement.findElements("RegularPeriods").first.text,
        nofOvertimes: xmlElement.findElements("NofOvertimes").first.text,
        withTie: xmlElement.findElements("WithTie").first.text,
        teamId: "",
        teamName: "",
      );
}

class Classement {
  final List<Team> teams;
  final Parameter parameter;

  Classement({required this.teams, required this.parameter});
}

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
      required this.leagueId});

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

  bool isHCVDTeam(int leagueId) {
    switch (leagueId) {
      case HCDV_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_TEAM_ID;

      case HCDV_U20_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_U20_TEAM_ID;

      case HCDV_U17_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_U17_TEAM_ID;

      case HCDV_U15_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_U15_TEAM_ID;

      case HCDV_U13TOP_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_U13TOP_TEAM_ID;

      case HCDV_U13A_LEAGUE_ID:
        return int.parse(teamId!) == HCDV_U13A_TEAM_ID;

      default:
        throw Exception(
            "[isHCDVTeam] Case doesn't match leagueId: ${leagueId}");
    }
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
      leagueId: leagueId);
}
