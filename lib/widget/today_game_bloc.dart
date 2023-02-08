import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hcdv_app/widget/today_game_list_element.dart';
import 'package:hcdv_app/xml/xml_models.dart';

class TodayGameBloc extends StatelessWidget {
  Result todayGamesResult;

  TodayGameBloc(this.todayGamesResult, {super.key});

  String getMatchStatusLibelle() {
    if (todayGamesResult.games.isEmpty) {
      return "";
    }

    switch (todayGamesResult.games[0].status) {
      case "0":
        return "${todayGamesResult.games[0].begin}";
      case "1":
        return "1er tiers";
      case "2":
        return "Pause 1er tiers";
      case "3":
        return "2ème tiers";
      case "4":
        return "Pause 2ème tiers";
      case "5":
        return "3ème tiers";
      case "6":
        return "Fin 3ème tiers";
      case "9":
        return "Fin du match";
      case "12":
        return "Match terminé";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 206, 39, 27),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Match du jour',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Card(
                child: Text(
                  getMatchStatusLibelle(),
                  style: const TextStyle(
                      backgroundColor: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
          todayGamesResult.games.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text("Pas de match aujourd'hui"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: todayGamesResult.games.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TodayGameListElement(todayGamesResult.games[index]);
                  }),
        ],
      ),
    );
  }
}
