class ListPlayerModel {
  int? accountId;
  String? steamid;
  String? avatar;
  String? avatarmedium;
  String? avatarfull;
  String? profileurl;
  String? personaname;
  String? lastLogin;
  String? fullHistoryTime;
  int? cheese;
  bool? fhUnavailable;
  String? loccountrycode;
  String? lastMatchTime;
  bool? plus;
  String? name;
  String? countryCode;
  int? fantasyRole;
  int? teamId;
  String? teamName;
  String? teamTag;
  bool? isLocked;
  bool? isPro;
  Null lockedUntil;

  ListPlayerModel(
      {this.accountId,
      this.steamid,
      this.avatar,
      this.avatarmedium,
      this.avatarfull,
      this.profileurl,
      this.personaname,
      this.lastLogin,
      this.fullHistoryTime,
      this.cheese,
      this.fhUnavailable,
      this.loccountrycode,
      this.lastMatchTime,
      this.plus,
      this.name,
      this.countryCode,
      this.fantasyRole,
      this.teamId,
      this.teamName,
      this.teamTag,
      this.isLocked,
      this.isPro,
      this.lockedUntil});

  ListPlayerModel.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    steamid = json['steamid'];
    avatar = json['avatar'];
    avatarmedium = json['avatarmedium'];
    avatarfull = json['avatarfull'];
    profileurl = json['profileurl'];
    personaname = json['personaname'];
    lastLogin = json['last_login'];
    fullHistoryTime = json['full_history_time'];
    cheese = json['cheese'];
    fhUnavailable = json['fh_unavailable'];
    loccountrycode = json['loccountrycode'];
    lastMatchTime = json['last_match_time'];
    plus = json['plus'];
    name = json['name'];
    countryCode = json['country_code'];
    fantasyRole = json['fantasy_role'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    teamTag = json['team_tag'];
    isLocked = json['is_locked'];
    isPro = json['is_pro'];
    lockedUntil = json['locked_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['steamid'] = steamid;
    data['avatar'] = avatar;
    data['avatarmedium'] = avatarmedium;
    data['avatarfull'] = avatarfull;
    data['profileurl'] = profileurl;
    data['personaname'] = personaname;
    data['last_login'] = lastLogin;
    data['full_history_time'] = fullHistoryTime;
    data['cheese'] = cheese;
    data['fh_unavailable'] = fhUnavailable;
    data['loccountrycode'] = loccountrycode;
    data['last_match_time'] = lastMatchTime;
    data['plus'] = plus;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['fantasy_role'] = fantasyRole;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['team_tag'] = teamTag;
    data['is_locked'] = isLocked;
    data['is_pro'] = isPro;
    data['locked_until'] = lockedUntil;
    return data;
  }
}
