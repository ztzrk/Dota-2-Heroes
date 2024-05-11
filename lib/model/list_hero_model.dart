class ListHeroModel {
  int? id;
  String? name;
  String? localizedName;
  String? primaryAttr;
  String? attackType;
  List<String>? roles;
  int? legs;

  ListHeroModel(
      {this.id,
      this.name,
      this.localizedName,
      this.primaryAttr,
      this.attackType,
      this.roles,
      this.legs});

  ListHeroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localized_name'];
    primaryAttr = json['primary_attr'];
    attackType = json['attack_type'];
    roles = json['roles'].cast<String>();
    legs = json['legs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['localized_name'] = localizedName;
    data['primary_attr'] = primaryAttr;
    data['attack_type'] = attackType;
    data['roles'] = roles;
    data['legs'] = legs;
    return data;
  }
}
