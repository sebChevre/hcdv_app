import 'package:flutter/material.dart';

import '../model/result.dart';
import 'last_game_list_element.dart';

class LastGameBloc extends StatelessWidget {
  Result lastGamesResult;

  LastGameBloc(this.lastGamesResult, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black,
        shadowColor: Colors.red,
        child: ExpansionTile(
          textColor: Colors.white,
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          title: const Text(
            'Résultats',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          children: [
            Column(
              children: [
                lastGamesResult.games.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Aucun résultats enregistrés",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lastGamesResult.games.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LastGameListElement(
                              lastGamesResult.games[index]);
                        }),
              ],
            )
          ],
        ));
  }
}
