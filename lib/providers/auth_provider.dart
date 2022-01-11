import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  static AuthProvider instance = AuthProvider();
  AuthStatus? status;
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
      SnackBarService.instance.showSnackBarSuccess('Successfully logged in!');
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError('Logging in failed!');
    }
    notifyListeners();
  }
}
