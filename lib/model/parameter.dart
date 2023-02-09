import 'package:xml/xml.dart';

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
