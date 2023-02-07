import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/enum/app-enum.dart';
import 'package:hcdv_app/xml/xml_models.dart';
import 'package:xml/xml.dart' as xml;

class L1Service {
  static final String LIGUE1_LAST_GAME_URL =
      dotenv.get('LIGUE1_LAST_GAME_URL', fallback: "LIGUE1_LAST_GAME_URL!");

  static final String LIGUE1_NEXT_GAME_URL = dotenv.get('LIGUE1_NEXT_GAME_URL',
      fallback: "LIGUE1_NEXT_GAME_URL env not found!");

  static final String LIGUE1_TODAY_GAME_URL = dotenv.get(
      'LIGUE1_TODAY_GAME_URL',
      fallback: "LIGUE1_TODAY_GAME_URL env not found!");

  static final String LIGUE1_CLASSEMENT_URL = dotenv.get(
      'LIGUE1_CLASSEMENT_URL',
      fallback: "LIGUE1_CLASSEMENT_URL env not found!");

  static final String LIGUE1_PO_LAST_GAME_URL = dotenv.get(
      'LIGUE1_PO_LAST_GAME_URL',
      fallback: "LIGUE1_PO_LAST_GAME_URL env not found!");

  static final String LIGUE1_PO_NEXT_GAME_URL = dotenv.get(
      'LIGUE1_PO_NEXT_GAME_URL',
      fallback: "LIGUE1_PO_NEXT_GAME_URL env not found!");

  static final String LIGUE1_PO_TODAY_GAME_URL = dotenv.get(
      'LIGUE1_PO_TODAY_GAME_URL',
      fallback: "LIGUE1_PO_TODAY_GAME_URL env not found!");

  static final String LIGUE1_PO_CLASSEMENT_GAME_URL = dotenv.get(
      'LIGUE1_PO_CLASSEMENT_GAME_URL',
      fallback: "LIGUE1_PO_CLASSEMENT_GAME_URL env not found!");

  static final Map<String, String> HEADERS = {};

  Future<Result> _loadMatchforGroup1L(String group) async {
    String url = "";

    switch (group) {
      case "last":
        url = LIGUE1_LAST_GAME_URL;
        break;
      case "today":
        url = LIGUE1_TODAY_GAME_URL;
        break;
      case "next":
        url = LIGUE1_NEXT_GAME_URL;
        break;
    }

    var file = await DefaultCacheManager().getSingleFile(url, headers: HEADERS);
    final contents = await file.readAsBytes();
    var response = String.fromCharCodes(contents);

    final document = xml.XmlDocument.parse(response);

    final resultNode = document.findElements('Result').single;

    Parameter parameter =
        Parameter.fromXmlElement(resultNode.findElements('Parameter').single);

    final gamesNode = resultNode.findElements("Games").first;

    List<Game> games = gamesNode
        .findElements("Game")
        .map((xmlElement) =>
            Game.fromXmlElement(parameter.leagueId, group, xmlElement))
        .toList();

    return Result(games: games, parameter: parameter, group: group);
  }

  Future<Result> _loadMatchforGroup1LPO(String group) async {
    String url = "";

    switch (group) {
      case "last":
        url = LIGUE1_PO_LAST_GAME_URL;
        break;
      case "today":
        url = LIGUE1_PO_TODAY_GAME_URL;
        break;
      case "next":
        url = LIGUE1_PO_NEXT_GAME_URL;
        break;
    }

    var file = await DefaultCacheManager().getSingleFile(url, headers: HEADERS);
    final contents = await file.readAsBytes();
    var response = String.fromCharCodes(contents);

    final document = xml.XmlDocument.parse(response);

    final resultNode = document.findElements('Result').single;

    Parameter parameter =
        Parameter.fromXmlElement(resultNode.findElements('Parameter').single);

    final gamesNode = resultNode.findElements("Games").first;

    List<Game> games = gamesNode
        .findElements("Game")
        .map((xmlElement) =>
            Game.fromXmlElement(parameter.leagueId, group, xmlElement))
        .toList();

    return Result(games: games, parameter: parameter, group: group);
  }

  Future<Classement> loadClassement(TypeMatch typeMatch) async {
    String url = typeMatch == TypeMatch.championnat
        ? LIGUE1_CLASSEMENT_URL
        : LIGUE1_PO_CLASSEMENT_GAME_URL;

    var file = await DefaultCacheManager().getSingleFile(url, headers: HEADERS);

    final contents = await file.readAsBytes();
    var response = String.fromCharCodes(contents);
    final document = xml.XmlDocument.parse(response);

    final resultNode = document.findElements('Ranking').single;

    Parameter parameter =
        Parameter.fromXmlElement(resultNode.findElements('Parameter').single);

    final teamsNode = resultNode.findElements("Teams").first;

    List<Team> games = teamsNode
        .findElements("Team")
        .map(
            (xmlElement) => Team.fromXmlElement(parameter.leagueId, xmlElement))
        .toList();

    return Classement(teams: games, parameter: parameter);
  }

  Future<Classement> loadClassementPO() async {
    var file = await DefaultCacheManager()
        .getSingleFile(LIGUE1_PO_CLASSEMENT_GAME_URL, headers: HEADERS);
    final contents = await file.readAsBytes();
    var response = String.fromCharCodes(contents);
    final document = xml.XmlDocument.parse(response);

    final resultNode = document.findElements('Ranking').single;

    Parameter parameter =
        Parameter.fromXmlElement(resultNode.findElements('Parameter').single);

    final teamsNode = resultNode.findElements("Teams").first;

    List<Team> games = teamsNode
        .findElements("Team")
        .map(
            (xmlElement) => Team.fromXmlElement(parameter.leagueId, xmlElement))
        .toList();

    return Classement(teams: games, parameter: parameter);
  }

  Future<List<Result>> load1LGames() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroup1L("last"));
      all.add(await _loadMatchforGroup1L("today"));
      all.add(await _loadMatchforGroup1L("next"));

      return all;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Result>> load1LPOGames() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroup1LPO("last"));
      all.add(await _loadMatchforGroup1LPO("today"));
      all.add(await _loadMatchforGroup1LPO("next"));

      return all;
    } catch (err) {
      rethrow;
    }
  }
}
