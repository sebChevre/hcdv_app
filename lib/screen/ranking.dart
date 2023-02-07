import 'package:flutter/material.dart';
import 'package:hcdv_app/enum/app-enum.dart';
import 'package:hcdv_app/widget/fixed-column-datatable.dart';
import 'package:hcdv_app/widget/scroll-column-datatable.dart';
import 'package:hcdv_app/xml/xml_models.dart';

import '../services/l1-service.dart';
import '../services/u15-service.dart';
import '../services/u17-service.dart';
import '../services/u20-service.dart';

class RankingScreen extends StatelessWidget {
  RankingScreen(this._ligue, this._typeMatch, {super.key});

  Ligue _ligue;
  TypeMatch _typeMatch;

  //Chargement des données
  Future<Classement> _loadClassement() async {
    switch (_ligue) {
      case Ligue.ligue1:
        return await L1Service().loadClassement(_typeMatch);

      case Ligue.u20:
        return await U20Service().loadClassement();

      case Ligue.u17:
        return await U17Service().loadClassement();

      case Ligue.u15:
        return await U15Service().loadClassement();

      default:
        throw Exception("[Ranking] Case doesnt match, _ligue: ${_ligue}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadClassement(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              // ignore: curly_braces_in_flow_control_structures
              return Column(children: [
                Padding(padding: EdgeInsets.all(8)),
                Card(
                  color: Color.fromARGB(255, 206, 39, 27),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${snapshot.data?.parameter.phaseNameF}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                SafeArea(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      FixedColumnDataTable(snapshot.requireData),
                      ScrollColumnDataTable(snapshot.requireData)
                    ],
                  ),
                ))
              ]);
          }
        });
  }
}
