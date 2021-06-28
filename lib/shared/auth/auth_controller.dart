import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(BuildContext context, UserModel? user) async {
    _user = user;

    if (user != null) {
      await saveUser(user);
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      removeUser();
      Navigator.pushReplacementNamed(context, "/login");
    }
    notifyListeners();
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    print(user.toJson());
    instance.setString("user", user.toJson());
  }

  Future<void> getCurrentAuth(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJson(json));
    } else {
      setUser(context, null);
    }
  }

  void removeUser() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove("user");
  }
}
