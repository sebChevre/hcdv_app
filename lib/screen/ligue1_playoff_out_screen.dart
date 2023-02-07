import 'package:flutter/material.dart';
import 'package:hcdv_app/enum/app-enum.dart';
import 'package:hcdv_app/widget/last_game_bloc.dart';
import 'package:hcdv_app/widget/next_game_bloc.dart';
import 'package:hcdv_app/widget/today_game_bloc.dart';

import '../services/l1-service.dart';
import '../xml/xml_models.dart';

class Ligue1PlayOffOutPage extends StatelessWidget {
  TypeStats typeStats;

  Ligue1PlayOffOutPage(this.typeStats, {super.key});

  Result resultFor(List<Result> resultats, String group) {
    return resultats.where((resultat) {
      return resultat.group == group;
    }).first;
  }

  // Chargement de la liste des matchs
  Future<List<Result>> _loadInitial1LGames() async {
    List<Result> resultats = await L1Service().load1LPOGames();

    return resultats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadInitial1LGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: typeStats == TypeStats.matchs
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(children: [
                            Padding(padding: EdgeInsets.all(8)),
                            Card(
                              color: Color.fromARGB(255, 206, 39, 27),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '${resultFor(snapshot.requireData, "today").parameter.phaseNameF}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ]),
                          const Padding(
                            padding: EdgeInsets.all(8),
                          ),
                          TodayGameBloc(
                              resultFor(snapshot.requireData, "today")),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          NextGameBloc(resultFor(snapshot.requireData, "next")),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          /** MATCH JOUES */
                          LastGameBloc(resultFor(snapshot.requireData, "last"))
                        ],
                      )
                    : Column(),
              );
            }
          }
        });
  }
}
