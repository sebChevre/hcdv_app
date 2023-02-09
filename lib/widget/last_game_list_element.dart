import 'package:flutter/material.dart';

import '../model/game.dart';
import '../util/date_util.dart';

class LastGameListElement extends StatelessWidget {
  final Game game;

  const LastGameListElement(this.game, {super.key});

  ShapeBorder getShapeForGame() {
    if (game.status == "18") {
      return const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 4),
          borderRadius: BorderRadius.all(Radius.circular(10)));
    } else {
      return game.isHCDVWinnerTeam(game.homeTeamId)
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
              // ignore: prefer_const_literals_to_create_immutables
              ? Row(children: [
                  const Expanded(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "ANNULE",
                      style: TextStyle(
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
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: getTextForHomeTeamName(game),
                    ),
                  )
                ],
              ),
              Column(children: [Row(children: getTeamScoreZone(game, true))]),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: getTextForAwayTeamName(game),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: getTeamScoreZone(game, false),
                  )
                ],
              ),
            ],
          ),
        ])));
  }

  Text getTextForHomeTeamName(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);

    //Si HCDV gras
    if (game.isHCDVHomeTeam(game.homeTeamId)) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.homeTeamName}", style: style);
  }

  Text getTextForAwayTeamName(Game game) {
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (!game.isHCDVHomeTeam(game.homeTeamId)) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${game.awayTeamName}", style: style);
  }

  List<Widget> getTeamScoreZone(Game game, bool forHome) {
    List<Widget> scoreZone = [];

    if (game.status == "18") {
      scoreZone.add(const Align(
        alignment: Alignment.centerRight,
        child: Text("-"),
      ));
    } else {
      scoreZone.addAll([
        SizedBox(
          width: 20,
          child: Align(
              alignment: Alignment.centerRight,
              child: forHome
                  ? getTextForHomeTeamScore(game)
                  : getTextForAwayTeamScore(game)),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: Color.fromARGB(255, 242, 240, 240),
          foregroundColor: Colors.black,
          child: Text(
            forHome
                ? "${game.detailedScore.homeFirstTierGoal}"
                : "${game.detailedScore.awayFirstTierGoal}",
            style: TextStyle(fontSize: 9),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 242, 240, 240),
          foregroundColor: Colors.black,
          radius: 10,
          child: Text(
            forHome
                ? "${game.detailedScore.homeSecondTierGoal}"
                : "${game.detailedScore.awaySecondTierGoal}",
            style: TextStyle(fontSize: 9),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 242, 240, 240),
          foregroundColor: Colors.black,
          radius: 10,
          child: Text(
            forHome
                ? "${game.detailedScore.homeThirdTierGoal}"
                : "${game.detailedScore.awayThirdTierGoal}",
            style: TextStyle(fontSize: 9),
          ),
        ),
      ]);

      if (game.decisionType == "2" ||
          game.decisionType == "3" ||
          game.decisionType == "4") {
        scoreZone.addAll([
          const Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          CircleAvatar(
            radius: 10,
            foregroundColor: Colors.black,
            child: Text(
              forHome
                  ? "${game.detailedScore.homeExtraTimeGoal}"
                  : "${game.detailedScore.awayExtraTimeGoal}",
              style: TextStyle(fontSize: 9),
            ),
          ),
        ]);
      }
    }

    return scoreZone;
  }

  Text getTextForHomeTeamScore(Game game) {
    String text = game.status == "18" ? "-" : "${game.homeScore}";
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (game.isHCDVHomeTeam(game.homeTeamId)) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${text}", style: style);
  }

  Text getTextForAwayTeamScore(Game game) {
    String text = game.status == "18" ? "-" : "${game.awayScore}";
    TextStyle style = const TextStyle(fontWeight: FontWeight.normal);
    //Si HCDV gras
    if (!game.isHCDVHomeTeam(game.homeTeamId)) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    return Text("${text}", style: style);
  }
}
