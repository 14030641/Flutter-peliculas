import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/user_dao.dart';
import 'package:practica2/src/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final picker = ImagePicker();
  String imagePath = "";
  DatabaseHelper _database;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtApellido = TextEditingController();
  TextEditingController txtTel = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  @override
  void initState() {
    _database = DatabaseHelper();
    userName();
    super.initState();
  }

  Future<void> userName() async {
    final SharedPreferences prefs = await _prefs;
    String value = prefs.getString("username");
    setState(() => txtEmail.text = value);
    recuperar();
  }

  void recuperar() async {
    UserDAO bridge = await _database.getUsuario(txtEmail.value.text);
    if (bridge != null) {
      setValues(bridge);
      setState(() {
        if (bridge.foto != null) imagePath = bridge.foto;
      });
    }
  }

  void setValues(user) async {
    if (user != null) {
      txtNombre.text = user.nomUser;
      txtApellido.text = user.lastUser;
      txtTel.text = user.telUser;
    }
  }

  void update() async {
    UserDAO bridge = await _database.getUsuario(txtEmail.value.text);
    UserDAO user = UserDAO(
      nomUser: txtNombre.text,
      lastUser: txtApellido.text,
      telUser: txtTel.text,
      emailUser: txtEmail.text,
      foto: imagePath,
      username: txtEmail.text,
      pwduser: "",
    );

    if (bridge != null) {
      //Si no es nulo, ya existe en la BD . . . UPDATE
      user.id = bridge.id;
      _database
          .actualizar(user.toJSON(), 'tbl_perfil')
          .then((rows) => {print('$rows')});
    } else {
      if (txtNombre.value.text != null && txtNombre.value.text != "")
        _database
            .insertar(user.toJSON(), 'tbl_perfil')
            .then((rows) => {print('$rows')});
    }

    //Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
        ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    final imgFinal = imagePath == ""
        ? Image.network(
            "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png",
          )
        : ClipOval(child: Image.file(File(imagePath), fit: BoxFit.fill));
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
                  Container(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      child: imgFinal,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Source'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Gallery source'),
                                    onPressed: () async {
                                      final pickedFile = await picker.getImage(
                                          source: ImageSource.gallery);
                                      imagePath = pickedFile.path;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Camera source'),
                                    onPressed: () async {
                                      final pickedFile = await picker.getImage(
                                          source: ImageSource.camera);
                                      imagePath = pickedFile.path;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Text("Nombre"),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: txtNombre,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu nombre(s)",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 20),
                  Text("Apellidos"),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: txtApellido,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu apellido(s)",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 20),
                  Text("Email"),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: txtEmail,
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu correo",
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20))),
                  SizedBox(height: 20),
                  Text("Teléfono"),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: txtTel,
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
                      onPressed: () async {
                        update();
                      }),
                ]),
              ),
            )));
  }
}
