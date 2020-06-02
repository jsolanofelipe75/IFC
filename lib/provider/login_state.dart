import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginState with ChangeNotifier {
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;
  var errorMessage = 'oops';

  SharedPreferences _prefs;

  

  bool _loggedIn = false;
  bool _isLoading = true;
  FirebaseUser _user;

  LoginState() {
    loginState();
  }

  bool isLoggedIn() => _loggedIn;
  bool isLoading() => _isLoading;

  FirebaseUser currentUser() => _user;

  void loginGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _handleSignIn();

      _isLoading = false;

      if (_user != null) {
        _prefs.setBool('isLoggedIn', true);
        _prefs.setString('uid', _user.uid);
        _loggedIn = true;
        if (_user != null) {
          _db.collection('usuarios').document(_user.uid).setData({
            'name': _user.displayName,
            'email': _user.email,
            'photoUrl': _user.photoUrl,
            'createdAt': DateTime.now(),
            'celular': ''
          });
        }
        notifyListeners();
      } else {
        _loggedIn = false;
        notifyListeners();
      }
    } on PlatformException catch (err) {
      if (err.code == 'sign_in_canceled') {
        print(err.toString());
        _isLoading = false;
        _loggedIn = false;
        notifyListeners();
      } else {
        throw err;
      }
      return null;
    }
  }

  void logout() {
    _prefs.clear();
    _auth.signOut();
    _googleSignIn.signOut();
    _loggedIn = false;
    notifyListeners();
  }

  Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

  void signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;

    notifyListeners();

    try {
      _user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      _isLoading = false;

      if (_user != null) {
        _prefs.setBool('isLoggedIn', true);
        _prefs.setString('uid', _user.uid);
        _loggedIn = true;

        notifyListeners();
      } else {
        _loggedIn = false;

        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      _loggedIn = false;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          print("EMAIL INCORRECTA.");
          break;
        case "ERROR_WRONG_PASSWORD":
          print("EMAIL INCORRECTA.");
          break;
        case "ERROR_USER_NOT_FOUND":
          print("EMAIL INCORRECTA.");
          break;
        case "ERROR_USER_DISABLED":
          print("EMAIL INCORRECTA.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          print("EMAIL INCORRECTA.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          print("EMAIL INCORRECTA.");
          break;
        default:
          print("EMAIL INCORRECTA.");
      }

      notifyListeners();
    }
  }

  void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn')) {
      _user = await _auth.currentUser();
      _loggedIn = _user != null;
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}
