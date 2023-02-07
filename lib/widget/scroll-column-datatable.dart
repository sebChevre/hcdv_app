import 'package:flutter/material.dart';

import '../xml/xml_models.dart';

class ScrollColumnDataTable extends StatelessWidget {
  final Classement classement;

  ScrollColumnDataTable(this.classement);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            dataRowHeight: 25,
            headingRowHeight: 25,
            headingRowColor: MaterialStateProperty.all(Colors.red),
            columnSpacing: 25,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.red,
                  width: 0.5,
                ),
              ),
            ),
            columns: [
              DataColumn(
                  label: Tooltip(
                message: "Matchs joués",
                child: Text('J', style: TextStyle(fontSize: 12)),
              )),
              DataColumn(
                  label: Tooltip(
                      message: "Points",
                      child: Text('P', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Matchs gagnés",
                      child: Text('V', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Matchs gagnés overtimes",
                      child: Text('V+', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Matchs perdus",
                      child: Text('L', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Matchs perdus overtime",
                      child: Text('L+', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Goals marquées",
                      child: Text('G+', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Goals reçus",
                      child: Text('G-', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Différences de buts",
                      child: Text('+/-', style: TextStyle(fontSize: 12)))),
              DataColumn(
                  label: Tooltip(
                      message: "Série",
                      child: Text('S', style: TextStyle(fontSize: 12))))
            ],
            rows: getRows()),
      ),
    );
  }

  List<DataRow> getRows() {
    return classement.teams
        .map((team) => DataRow(
              cells: [
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      team.games.toString(),
                      style: TextStyle(fontSize: 12),
                    ))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      team.points.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      team.gamesWonInTime.toString(),
                      style: TextStyle(fontSize: 12),
                    ))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.gamesWonExtraTime.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.gamesLostInTime.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.gamesLostExtraTime.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.goalsFor.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.goalsAgainst.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.goalsDifference.toString(),
                        style: TextStyle(fontSize: 12)))),
                DataCell(Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(team.streak.toString(),
                        style: TextStyle(fontSize: 12)))),
              ],
            ))
        .toList();
  }
}
