import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/model/groupe-match.dart';
import '../model/classement.dart';
import '../model/game.dart';
import '../model/parameter.dart';
import '../model/result.dart';
import '../model/team.dart';
import 'package:xml/xml.dart' as xml;

class U13AService {
  static final String U13A_LAST_GAME_URL = dotenv.get('U13A_LAST_GAME_URL',
      fallback: "U13A_LAST_GAME_URL env not found!");

  static final String U13A_NEXT_GAME_URL = dotenv.get('U13A_NEXT_GAME_URL',
      fallback: "U13A_NEXT_GAME_URL env not found!");

  static final String U13A_TODAY_GAME_URL = dotenv.get('U13A_TODAY_GAME_URL',
      fallback: "U13A_TODAY_GAME_URL env not found!");

  static final Map<String, String> HEADERS = {};

  Future<Result> _loadMatchforGroupU13A(GroupeMatch groupe) async {
    String url = "";

    switch (groupe) {
      case GroupeMatch.LAST:
        url = U13A_LAST_GAME_URL;
        break;
      case GroupeMatch.TODAY:
        url = U13A_TODAY_GAME_URL;
        break;
      case GroupeMatch.NEXT:
        url = U13A_NEXT_GAME_URL;
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

  Future<List<Result>> loadU13AGames() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroupU13A(GroupeMatch.LAST));
      all.add(await _loadMatchforGroupU13A(GroupeMatch.TODAY));
      all.add(await _loadMatchforGroupU13A(GroupeMatch.NEXT));

      return all;
    } catch (err) {
      rethrow;
    }
  }
}
