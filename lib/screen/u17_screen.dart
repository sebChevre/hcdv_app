import 'package:flutter/material.dart';
import 'package:hcdv_app/widget/last_game_bloc.dart';
import 'package:hcdv_app/widget/next_game_bloc.dart';
import 'package:hcdv_app/widget/today_game_bloc.dart';

import '../model/groupe-match.dart';
import '../model/result.dart';
import '../model/type-stats.dart';
import '../services/u17-service.dart';

class U17LiguePage extends StatelessWidget {
  final TypeStats typeStats;

  const U17LiguePage(this.typeStats, {super.key});

  Future<List<Result>> _loadInitialU17Games() async {
    List<Result> resultats = await U17Service().loadU17Games();

    return resultats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadInitialU17Games(),
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
                                  '${Result.resultFor(snapshot.requireData, GroupeMatch.TODAY).parameter.phaseNameF}',
                                  style: const TextStyle(
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
                          TodayGameBloc(Result.resultFor(
                              snapshot.requireData, GroupeMatch.TODAY)),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          NextGameBloc(Result.resultFor(
                              snapshot.requireData, GroupeMatch.NEXT)),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          /** MATCH JOUES */
                          LastGameBloc(Result.resultFor(
                              snapshot.requireData, GroupeMatch.LAST)),
                        ],
                      )
                    : Column(),
              );
            }
          }
        });
  }
}
