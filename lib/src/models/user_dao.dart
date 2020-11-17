import 'dart:convert';

class UserDAO {
  String username;
  String pwduser;

  int id;
  String nomUser;
  String lastUser;
  String telUser;
  String emailUser;
  String foto;

  UserDAO(
      {this.id,
      this.username,
      this.pwduser,
      this.nomUser,
      this.lastUser,
      this.telUser,
      this.emailUser,
      this.foto});

  factory UserDAO.fromJSON(Map<String, dynamic> map) {
    return UserDAO(
      id: map['id'],
      nomUser: map['nomUser'],
      lastUser: map['lastUser'],
      telUser: map['telUser'],
      emailUser: map['emailUser'],
      foto: map['foto'],
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "nomUser": nomUser,
      "lastUser": lastUser,
      "telUser": telUser,
      "emailUser": emailUser,
      "foto": foto,
      "username": username,
      "pwduser": pwduser
    };
  }

  String userToJSON() {
    final mapUser = this.toJSON();
    return json.encode(mapUser);
  }
}
