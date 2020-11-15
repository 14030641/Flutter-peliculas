import 'package:http/http.dart' show Client;

class ApiLogin {
  final String ENDPOINT = "http:://127.0.0.1:8888/login";
  Client http = Client();

  Future<String> validateUser() async {
    final response = await http.post(ENDPOINT);
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }
}
