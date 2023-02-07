import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/xml/xml_models.dart';
import 'package:xml/xml.dart' as xml;

class U13TopService {
  static final String U13TOP_LAST_GAME_URL = dotenv.get('U13TOP_LAST_GAME_URL',
      fallback: "U13TOP_LAST_GAME_URL env not found!");

  static final String U13TOP_NEXT_GAME_URL = dotenv.get('U13TOP_NEXT_GAME_URL',
      fallback: "U13TOP_NEXT_GAME_URL env not found!");

  static final String U13TOP_TODAY_GAME_URL = dotenv.get(
      'U13TOP_TODAY_GAME_URL',
      fallback: "U13TOP_TODAY_GAME_URL env not found!");

  static final Map<String, String> HEADERS = {};

  Future<Result> _loadMatchforGroupU13Top(String group) async {
    String url = "";

    switch (group) {
      case "last":
        url = U13TOP_LAST_GAME_URL;
        break;
      case "today":
        url = U13TOP_TODAY_GAME_URL;
        break;
      case "next":
        url = U13TOP_NEXT_GAME_URL;
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

  Future<List<Result>> loadU13TopGames() async {
    List<Result> all = [];

    try {
      all.add(await _loadMatchforGroupU13Top("last"));
      all.add(await _loadMatchforGroupU13Top("today"));
      all.add(await _loadMatchforGroupU13Top("next"));

      return all;
    } catch (err) {
      rethrow;
    }
  }
}
