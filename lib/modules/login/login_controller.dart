import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoUrl: response.photoUrl,
      );
      var auth = context.read<AuthController>();
      auth.setUser(context, user);
    } catch (error) {
      print(error);
    }
  }

  void googleSignOut(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }
    var auth = context.read<AuthController>();
    auth.setUser(context, null);
  }
}
