class PlayerModel {
  Profile? profile;
  int? rankTier;
  int? leaderboardRank;

  PlayerModel({this.profile, this.rankTier, this.leaderboardRank});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    rankTier = json['rank_tier'];
    leaderboardRank = json['leaderboard_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['rank_tier'] = this.rankTier;
    data['leaderboard_rank'] = this.leaderboardRank;
    return data;
  }
}

class Profile {
  int? accountId;
  String? personaname;
  String? name;
  bool? plus;
  int? cheese;
  String? steamid;
  String? avatar;
  String? avatarmedium;
  String? avatarfull;
  String? profileurl;
  String? loccountrycode;
  bool? fhUnavailable;
  bool? isContributor;
  bool? isSubscriber;

  Profile(
      {this.accountId,
      this.personaname,
      this.name,
      this.plus,
      this.cheese,
      this.steamid,
      this.avatar,
      this.avatarmedium,
      this.avatarfull,
      this.profileurl,
      this.loccountrycode,
      this.fhUnavailable,
      this.isContributor,
      this.isSubscriber});

  Profile.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    personaname = json['personaname'];
    name = json['name'];
    plus = json['plus'];
    cheese = json['cheese'];
    steamid = json['steamid'];
    avatar = json['avatar'];
    avatarmedium = json['avatarmedium'];
    avatarfull = json['avatarfull'];
    profileurl = json['profileurl'];
    loccountrycode = json['loccountrycode'];
    fhUnavailable = json['fh_unavailable'];
    isContributor = json['is_contributor'];
    isSubscriber = json['is_subscriber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['personaname'] = personaname;
    data['name'] = name;
    data['plus'] = plus;
    data['cheese'] = cheese;
    data['steamid'] = steamid;
    data['avatar'] = avatar;
    data['avatarmedium'] = avatarmedium;
    data['avatarfull'] = avatarfull;
    data['profileurl'] = profileurl;
    data['loccountrycode'] = loccountrycode;
    data['fh_unavailable'] = fhUnavailable;
    data['is_contributor'] = isContributor;
    data['is_subscriber'] = isSubscriber;
    return data;
  }
}
