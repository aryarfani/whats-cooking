import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/provider/user_provider.dart';
import 'package:whats_cooking/core/utils/router.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProv, child) {
        if (userProv.loginState == LoginState.loading) {
          userProv.getUser();
        }
        if (userProv.loginState == LoginState.isSigned) {
          // for fixing setState() or markNeedsBuild() Error called during build.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(RouteName.home);
          });
        } else if (userProv.loginState == LoginState.notSigned) {
          return _buildScreen(userProv, context);
        }
        return _buildScreen(userProv, context);
      },
    );
  }

  Widget _buildScreen(UserProvider userProv, BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('images/logo.png')),
              _signInButton(context, userProv),
            ],
          ),
        ),
      ),
    );
  }

  _signInButton(context, userProv) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        userProv.login();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
