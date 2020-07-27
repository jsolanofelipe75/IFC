import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginState with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;

  SharedPreferences _prefs;

  bool _loggedIn = false;
  bool _isLoading = true;
  FirebaseUser _user;
  String _token;

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
            'createdAt': DateTime.now().millisecondsSinceEpoch,
            'celular': _user.phoneNumber
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
  void loginFacebook() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _handleFacebookSignIn();

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
            'createdAt': DateTime.now().millisecondsSinceEpoch,
            'celular': _user.phoneNumber
          });
        }
        notifyListeners();
      } else {
        _loggedIn = false;
        notifyListeners();
      }
    } on PlatformException catch (err) {
        print(err.toString());
        _isLoading = false;
        _loggedIn = false;
        notifyListeners();

      return null;
    }
  }

  _printCredentials(LoginResult result) {
    _token = result.accessToken.token;
    print("userId: ${result.accessToken.userId}");
    print("token: $_token");
    print("expires: ${result.accessToken.expires}");
    print("grantedPermission: ${result.grantedPermissions}");
    print("declinedPermissions: ${result.declinedPermissions}");
  }

  Future<FirebaseUser> _handleFacebookSignIn() async {
    final result = await FacebookAuth.instance.login();

    switch (result.status) {
      case FacebookAuthLoginResponse.ok: // result.status == 200
        _printCredentials(result);
        break;
      case FacebookAuthLoginResponse.cancelled: // result.status == 403
        print("login cancelled");
        break;
      default: // result.status == 500
        print("login failed");
    }
  

    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
      
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }



  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
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
          print("CONTRASEÑA INCORRECTA.");
          break;
        case "ERROR_USER_NOT_FOUND":
          print("USUARIO NO ENCONTRADO.");
          break;
        case "ERROR_USER_DISABLED":
          print("USUARIO DESACTIVADO.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          print("ERROR EN LAS PETICIONES.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          print("OPERACIÓN NO PERMITIDA.");
          break;
        default:
          print("ERROR DESCONOCIDO.");
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

  void logout() {
    _prefs.clear();
    _auth.signOut();
    _googleSignIn.signOut();
    _loggedIn = false;
    notifyListeners();
  }
}
