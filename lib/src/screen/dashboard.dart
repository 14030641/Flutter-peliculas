import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Configuration.colorApp,
          title: Text('Peliculas'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Configuration.colorApp,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png'),
                ),
                accountName: Text('ISC. Carlos Eugenio Torres Mota'),
                accountEmail: Text('14030641@itcelaya.edu.mx'),
                onDetailsPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.trending_up, color: Configuration.colorItems),
                title: Text('Trending'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/trending');
                },
              ),
              ListTile(
                leading: Icon(Icons.search, color: Configuration.colorItems),
                title: Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/search');
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Configuration.colorItems),
                title: Text('Favorites'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorites');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.exit_to_app, color: Configuration.colorItems),
                title: Text('Sign Out'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
