class DetailedScore {
  int homeFirstTierGoal = 0;
  int awayFirstTierGoal = 0;
  int homeSecondTierGoal = 0;
  int awaySecondTierGoal = 0;
  int homeThirdTierGoal = 0;
  int awayThirdTierGoal = 0;
  int? homeExtraTimeGoal;
  int? awayExtraTimeGoal;
  String thirdResults;
  String decisionType;
  String status;

  DetailedScore(this.thirdResults, this.decisionType, this.status) {
    if (status != "18" && status != "0") {
      List<String> periods = thirdResults.split(",");

      homeFirstTierGoal = int.parse(periods[0].split(":")[0]);
      awayFirstTierGoal = int.parse(periods[0].split(":")[1]);

      homeSecondTierGoal = int.parse(periods[1].split(":")[0]);
      awaySecondTierGoal = int.parse(periods[1].split(":")[1]);

      homeThirdTierGoal = int.parse(periods[2].split(":")[0]);
      awayThirdTierGoal = int.parse(periods[2].split(":")[1]);

      if (decisionType == "2") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal =
            int.parse(periods[3].split(":")[1].replaceAll("[+1]", ""));
      }

      if (decisionType == "3") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal =
            int.parse(periods[3].split(":")[1].replaceAll("[p]", ""));
      }

      if (decisionType == "4") {
        homeExtraTimeGoal = int.parse(periods[3].split(":")[0]);
        awayExtraTimeGoal = int.parse(periods[3]
            .split(":")[1]
            .replaceAll("[+1", "")
            .replaceAll(",p]", ""));
      }
    }
  }
}
