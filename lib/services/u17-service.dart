import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/model/groupe-match.dart';

import 'package:xml/xml.dart' as xml;

import '../model/classement.dart';
import '../model/game.dart';
import '../model/parameter.dart';
import '../model/result.dart';
import '../model/team.dart';

class U17Service {
  static final String U17_LAST_GAME_URL = dotenv.get('U17_LAST_GAME_URL',
      fallback: "U17_LAST_GAME_URL env not found!");

  static final String U17_NEXT_GAME_URL = dotenv.get('U17_NEXT_GAME_URL',
      fallback: "U17_NEXT_GAME_URL env not found!");

  static final String U17_TODAY_GAME_URL = dotenv.get('U17_TODAY_GAME_URL',
      fallback: "U17_TODAY_GAME_URL env not found!");

  static final String U17_CLASSEMENT_URL = dotenv.get('U17_CLASSEMENT_URL',
      fallback: "U17_CLASSEMENT_URL env not found!");

  static final Map<String, String> HEADERS = {};

  Future<Result> _loadMatchforGroupU17(GroupeMatch groupe) async {
    String url = "";

    switch (groupe) {
      case GroupeMatch.LAST:
        url = U17_LAST_GAME_URL;
        break;
      case GroupeMatch.TODAY:
        url = U17_TODAY_GAME_URL;
        break;
      case GroupeMatch.NEXT:
        url = U17_NEXT_GAME_URL;
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
            Game.fromXmlElement(parameter.leagueId, groupe, xmlElement))
        .toList();

    return Result(parameter: parameter, games: games, groupe: groupe);
  }

  Future<List<Result>> loadU17Games() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroupU17(GroupeMatch.LAST));
      all.add(await _loadMatchforGroupU17(GroupeMatch.TODAY));
      all.add(await _loadMatchforGroupU17(GroupeMatch.NEXT));

      return all;
    } catch (err) {
      rethrow;
    }
  }

  Future<Classement> loadClassement() async {
    var file = await DefaultCacheManager()
        .getSingleFile(U17_CLASSEMENT_URL, headers: HEADERS);
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
