import 'dart:convert';

class UserModel {
  final String name;
  final String? photoUrl;

  UserModel({required this.name, this.photoUrl});

  String get nickname => name.split(" ")[0];

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map["name"], photoUrl: map["photoUrl"]);
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() => {"name": name, "photoUrl": photoUrl};

  String toJson() => jsonEncode(toMap());
}
