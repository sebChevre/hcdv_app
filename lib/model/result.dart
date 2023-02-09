import 'package:hcdv_app/model/groupe-match.dart';
import 'package:hcdv_app/model/parameter.dart';

import 'game.dart';

class Result {
  Result({
    required this.parameter,
    required this.games,
    required this.groupe,
  });

  final Parameter parameter;
  final List<Game> games;
  final GroupeMatch groupe;

  static Result resultFor(List<Result> resultats, GroupeMatch groupe) {
    return resultats.where((resultat) {
      return resultat.groupe == groupe;
    }).first;
  }
}
