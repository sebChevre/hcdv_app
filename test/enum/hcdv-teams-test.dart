import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hcdv_app/model/hcdv-team.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load();

  String correct1LTeamId = dotenv.get("HCDV_TEAM_ID");

  test('Test hcdv team enum throw exception when not match', () {
    expect(() => HcdvTeam.resolveByTeamId("1"), HcdvTeam.NO_HCDV_TEAM);
  });

  test('Test hcdv team enum throw exception when not match', () {
    expect(() {
      HcdvTeam.resolveByTeamId(correct1LTeamId);
    }, HcdvTeam.Equipe1);
  });
}
