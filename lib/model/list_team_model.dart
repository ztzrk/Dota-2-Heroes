class ListTeamModel {
  num? teamId;
  num? rating;
  num? wins;
  num? losses;
  num? lastMatchTime;
  String? name;
  String? tag;
  String? logoUrl;

  ListTeamModel(
      {this.teamId,
      this.rating,
      this.wins,
      this.losses,
      this.lastMatchTime,
      this.name,
      this.tag,
      this.logoUrl});

  ListTeamModel.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    rating = json['rating'];
    wins = json['wins'];
    losses = json['losses'];
    lastMatchTime = json['last_match_time'];
    name = json['name'];
    tag = json['tag'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['rating'] = rating;
    data['wins'] = wins;
    data['losses'] = losses;
    data['last_match_time'] = lastMatchTime;
    data['name'] = name;
    data['tag'] = tag;
    data['logo_url'] = logoUrl;
    return data;
  }
}
