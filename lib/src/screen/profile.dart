import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Perfil"),
              backgroundColor: Configuration.colorApp,
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: ListView(children: <Widget>[
                  InkWell(
                    child: Image.network(
                      "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png",
                      width: 180,
                      height: 180,
                    ),
                    onTap: () {
                      debugPrint("Clic en imagen");
                    },
                  ),
                  Text("Nombre"),
                  SizedBox(height: 10),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu nombre completo",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 20),
                  Text("Email"),
                  SizedBox(height: 10),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu correo",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 20),
                  Text("Teléfono"),
                  SizedBox(height: 10),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu numero de teléfono",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 10),
                  RaisedButton(
                      child: Text('Actualizar',
                          style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Configuration.colorApp,
                      onPressed: () {
                        debugPrint("Actualizar");
                      }),
                ]),
              ),
            )));
  }
}
