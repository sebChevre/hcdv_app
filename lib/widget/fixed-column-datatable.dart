import 'package:flutter/material.dart';

import '../model/classement.dart';

class FixedColumnDataTable extends StatelessWidget {
  final Classement classement;

  FixedColumnDataTable(this.classement);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 1,
      dataRowHeight: 25,
      headingRowHeight: 25,
      headingRowColor:
          MaterialStateProperty.all(Color.fromARGB(255, 206, 39, 27)),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      columns: [
        DataColumn(
          label: Text('Equipes',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
      rows: getRows(),
    );
  }

  List<DataRow> getRows() {
    return classement.teams.map((team) {
      return DataRow(cells: [
        DataCell(Text(
          '${team.pos}  ${team.teamName}',
          style: team.isHCVDTeam(int.parse(classement.parameter.leagueId))
              ? TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
              : TextStyle(fontSize: 12),
        ))
      ]);
    }).toList();
  }
}
