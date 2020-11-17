import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/user_dao.dart';
import 'package:practica2/src/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _usr = "";

  @override
  void initState() {
    userName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();
    Future<UserDAO> _objUser =
        _database.getUsuario(_usr); //Lectura debe ser de shared preferences
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Configuration.colorApp,
          title: Text('Peliculas'),
        ),
        drawer: Drawer(
          child: FutureBuilder(
            future: _objUser,
            builder: (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
              return ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Configuration.colorApp,
                    ),
                    currentAccountPicture: profPic(snapshot.data),
                    accountName: Text((snapshot.data != null)
                        ? snapshot.data.nomUser + ' ' + snapshot.data.lastUser
                        : " "),
                    accountEmail: Text((snapshot.data != null)
                        ? snapshot.data.emailUser
                        : " "),
                    onDetailsPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.trending_up,
                        color: Configuration.colorItems),
                    title: Text('Trending'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/trending');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.search, color: Configuration.colorItems),
                    title: Text('Search'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.favorite, color: Configuration.colorItems),
                    title: Text('Favorites'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/favorites');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app,
                        color: Configuration.colorItems),
                    title: Text('Sign Out'),
                    onTap: () {
                      clearToken();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()),
                          ModalRoute.withName('/login'));
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> clearToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("token", null);
  }

  Future<void> userName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _usr = prefs.getString("username"));
  }

  Widget profPic(data) {
    if (data == null || data.foto == null || data.foto == "")
      return CircleAvatar(
        backgroundImage: NetworkImage(
            "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png"),
      );
    else {
      return ClipOval(
          child: Image.file(
        File(data.foto),
        fit: BoxFit.cover,
      ));
    }
  }
}
