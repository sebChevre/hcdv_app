import 'package:flutter/material.dart';
import 'package:hcdv_app/xml/xml_models.dart';

import 'last_game_list_element.dart';
import 'next_game_list_element.dart';

class NextGameBloc extends StatelessWidget {
  Result nextGamesResult;

  NextGameBloc(this.nextGamesResult, {super.key});

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
            "Prochains matchs",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          children: [
            Column(
              children: [
                nextGamesResult.games.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Plus de match(s) prévu(s)",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: nextGamesResult.games.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NextGameListElement(
                              nextGamesResult.games[index]);
                        }),
              ],
            )
          ],
        ));
  }
}
