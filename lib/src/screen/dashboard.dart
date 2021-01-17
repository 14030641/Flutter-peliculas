import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/user_dao.dart';
import 'package:practica2/src/network/api_movies.dart';
import 'package:practica2/src/screen/login.dart';
import 'package:practica2/src/screen/search.dart';
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
    TextEditingController txtSearch = TextEditingController();
    Future<UserDAO> _objUser =
        _database.getUsuario(_usr); //Lectura debe ser de shared preferences

    ApiMovies apimovie = ApiMovies();
    apimovie.getTrending();
    return Container(
      child: Scaffold(
          backgroundColor: Configuration.colorMain,
          appBar: AppBar(
            backgroundColor: Configuration.colorMain,
            title: Text('Peliculas'),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: txtSearch,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      fillColor: Configuration.colorApp,
                      filled: true,
                      hintText: "Ingrese su busqueda",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10))),
              RaisedButton(
                  child: Text("Buscar"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Configuration.colorItems,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Search(search: txtSearch.text)));
                  }),
            ],
          ),
          drawer: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Configuration.colorMain),
            child: Drawer(
              child: FutureBuilder(
                future: _objUser,
                builder:
                    (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
                  return ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Configuration.colorApp,
                        ),
                        currentAccountPicture: profPic(snapshot.data),
                        accountName: Text((snapshot.data != null)
                            ? snapshot.data.nomUser +
                                ' ' +
                                snapshot.data.lastUser
                            : "Invitado"),
                        accountEmail: Text((snapshot.data != null)
                            ? snapshot.data.emailUser
                            : "invitado@itcelaya.edu.mx"),
                        onDetailsPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.trending_up,
                            color: Configuration.colorItems),
                        title: Text(
                          'Trending',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/trending');
                        },
                      ),
                      /*ListTile(
                        leading:
                            Icon(Icons.search, color: Configuration.colorItems),
                        title: Text('Search',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/search');
                        },
                      ),*/
                      ListTile(
                        leading: Icon(Icons.favorite,
                            color: Configuration.colorItems),
                        title: Text('Favorites',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/favorites');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.exit_to_app,
                            color: Configuration.colorItems),
                        title: Text('Sign Out',
                            style: TextStyle(color: Colors.white)),
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
          )),
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
    if (data == null || data.foto == null)
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
