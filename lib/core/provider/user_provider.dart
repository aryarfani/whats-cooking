import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whats_cooking/core/service/authentication_firebase.dart';

enum LoginState { loading, isSigned, notSigned }

class UserProvider extends ChangeNotifier {
  FirebaseUser get currentUser => _currentUser;
  FirebaseUser _currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // set initial state to loading
  LoginState loginState = LoginState.loading;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void login() async {
    _currentUser = await signInWithGoogle();
    loginState = LoginState.isSigned;
    print("_currentUser = " + _currentUser.displayName);
    notifyListeners();
  }

  void loginWithNumber(String number) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        var authResult = await _auth.signInWithCredential(credential);
        if (authResult.user != null) {
          print('login success');
        }
        // doLogicLogin(authResult);
      },
      verificationFailed: (err) {
        print(err.message);
      },
      codeSent: (String verificationId, [int codeSent]) async {
        // var credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: number);
        // var authResult = await _auth.signInWithCredential(credential);
        // doLogicLogin(authResult);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print(verificationId);
        print("codeAutoRetrievalTimeout");
      },
    );
  }

  // void doLogicLogin(AuthResult authResult) async {
  //   // fill the login with user
  //   _currentUser = authResult.user;
  //   loginState = LoginState.isSigned;
  //   print("_currentUser = " + _currentUser.displayName);
  //   notifyListeners();
  // }

  void logout() {
    signOutGoogle();
    _firebaseAuth.signOut();
    // _favoriteRecipes = null;
    loginState = LoginState.notSigned;
    _currentUser = null;
    notifyListeners();
  }

  void getUser() async {
    _currentUser = await _firebaseAuth.currentUser();
    if (_currentUser == null) {
      loginState = LoginState.notSigned;
    } else {
      loginState = LoginState.isSigned;
    }
    notifyListeners();
  }
}
