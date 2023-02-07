import 'package:flutter/material.dart';

import '../util/date_util.dart';
import '../xml/xml_models.dart';

class NextGameListElement extends StatelessWidget {
  final Game game;

  const NextGameListElement(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 242, 241, 241),
      child: ListTile(
          title: Column(children: [
        Row(children: [
          Expanded(
              child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              DateUtil.formatDateAsString(game.beginDateTime),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )),
        ]),
        Row(children: [
          Expanded(
              child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "${game.arena}",
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            ),
          )),
        ]),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: getTextForHomeTeamName(game),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: getTextForHomeTeamScore(game),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: getTextForAwayTeamName(game),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: getTextForAwayTeamScore(game),
                ),
              ],
            ),
          ],
        ),
      ])),
    );
  }

  Text getTextForHomeTeamName(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.homeTeamName}", style: style);
  }

  Text getTextForAwayTeamName(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (!game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.awayTeamName}", style: style);
  }

  Text getTextForHomeTeamScore(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.homeScore}", style: style);
  }

  Text getTextForAwayTeamScore(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (!game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.awayScore}", style: style);
  }
}
