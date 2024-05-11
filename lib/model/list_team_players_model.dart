class ListTeamPlayersModel {
  int? accountId;
  String? name;
  int? gamesPlayed;
  int? wins;
  bool? isCurrentTeamMember;

  ListTeamPlayersModel(
      {this.accountId,
      this.name,
      this.gamesPlayed,
      this.wins,
      this.isCurrentTeamMember});

  ListTeamPlayersModel.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    name = json['name'];
    gamesPlayed = json['games_played'];
    wins = json['wins'];
    isCurrentTeamMember = json['is_current_team_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['name'] = name;
    data['games_played'] = gamesPlayed;
    data['wins'] = wins;
    data['is_current_team_member'] = isCurrentTeamMember;
    return data;
  }
}
