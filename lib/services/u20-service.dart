import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/xml/xml_models.dart';
import 'package:xml/xml.dart' as xml;

class U20Service {
  static final String U20_LAST_GAME_URL = dotenv.get('U20_LAST_GAME_URL',
      fallback: "U20_LAST_GAME_URL env not found!");

  static final String U20_NEXT_GAME_URL = dotenv.get('U20_NEXT_GAME_URL',
      fallback: "U20_NEXT_GAME_URL env not found!");

  static final String U20_TODAY_GAME_URL = dotenv.get('U20_TODAY_GAME_URL',
      fallback: "U20_TODAY_GAME_URL env not found!");

  static final String U20_CLASSEMENT_URL = dotenv.get('U20_CLASSEMENT_URL',
      fallback: "U20_CLASSEMENT_URL env not found!");

  static final Map<String, String> HEADERS = {};

  Future<Result> _loadMatchforGroupU20(String group) async {
    String url = "";

    switch (group) {
      case "last":
        url = U20_LAST_GAME_URL;
        break;
      case "today":
        url = U20_TODAY_GAME_URL;
        break;
      case "next":
        url = U20_NEXT_GAME_URL;
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

    return Result(parameter: parameter, games: games, group: group);
  }

  Future<List<Result>> loadU20Games() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroupU20("last"));
      all.add(await _loadMatchforGroupU20("today"));
      all.add(await _loadMatchforGroupU20("next"));

      return all;
    } catch (err) {
      rethrow;
    }
  }

  Future<Classement> loadClassement() async {
    var file = await DefaultCacheManager()
        .getSingleFile(U20_CLASSEMENT_URL, headers: HEADERS);
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
}
