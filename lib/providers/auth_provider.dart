import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  static AuthProvider instance = AuthProvider();
  late AuthStatus status;
  late FirebaseAuth _auth;
  late UserCredential _result;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      status = AuthStatus.Authenticated;
      print(_result.user!.email);
    } catch (e) {
      status = AuthStatus.Error;
    }
    notifyListeners();
  }
}
