import 'package:flutter/material.dart';

import '../util/date_util.dart';
import '../xml/xml_models.dart';

class LastGameListElement extends StatelessWidget {
  final Game game;

  const LastGameListElement(this.game, {super.key});

  ShapeBorder getShapeForGame() {
    if (game.status == "18") {
      return const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 4),
          borderRadius: BorderRadius.all(Radius.circular(10)));
    } else {
      return game.isHCDVWinnerTeam(int.parse(game.leagueId))
          ? const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)))
          : const RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: getShapeForGame(),
        child: ListTile(
            title: Column(children: [
          Row(children: [
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                DateUtil.formatDateAsString(game.beginDateTime),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            )),
          ]),
          Row(children: [
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "${game.arena}",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              ),
            )),
          ]),
          game.status == "18"
              ? Row(children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "ANNULE",
                      style: const TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontSize: 12),
                    ),
                  )),
                ])
              : Container(),
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
        ])));
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
    String text = game.status == "18" ? "-" : "${game.homeScore}";
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${text}", style: style);
  }

  Text getTextForAwayTeamScore(Game game) {
    String text = game.status == "18" ? "-" : "${game.awayScore}";
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (!game.isHCDVHomeTeam(int.parse(game.leagueId))) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${text}", style: style);
  }
}
