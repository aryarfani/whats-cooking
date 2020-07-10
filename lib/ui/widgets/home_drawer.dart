import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/provider/user_provider.dart';
import 'package:whats_cooking/core/utils/router.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProv, chikd) {
        return Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'What\'s cooking ?',
                    style: GoogleFonts.lato(),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.help),
                  title: Text('Help'),
                  subtitle: Text('Are you lost ?'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.favorite),
                  title: Text('Favorite Recipe'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(RouteName.favoriteRecipe);
                  },
                ),
                Divider(
                  color: Colors.black26,
                  thickness: 1.5,
                ),
                ListTile(
                  trailing: Icon(Icons.lock_open),
                  title: Text('Log Out'),
                  onTap: () {
                    userProv.logout();
                    Navigator.pushReplacementNamed(context, RouteName.signIn);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
