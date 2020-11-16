import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/user_dao.dart';

class ApiLogin {
  final String ENDPOINT = "http://192.168.1.145:8888/signup";
  Client http = Client();

  Future<String> validateUser(UserDAO objUser) async {
    final response = await http.post(
      '$ENDPOINT',
      /*headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },*/
      body: objUser.toJSON(),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
