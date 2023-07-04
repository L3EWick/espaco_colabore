import 'dart:convert';
import 'package:colabore/screens/api_response.dart';
import 'package:colabore/screens/login/usuario.dart';
import 'package:colabore/screens/utils/url.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      // var url = 'http://' + link + '/api/login';

      var url = Uri.http(link, '/api/login');

      print(url);
      Map<String, String> headers = {"Content-type": "aplication/json"};

      Map params = {
        'email': login,
        'password': senha,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(json.decode(response.body));

        user.save();

        Usuario? user2 = await Usuario.get();
        // ignore: avoid_print
        print("user2: $user2");

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(json.decode(response.body)["message"]);
    } catch (error, exception) {
      // ignore: avoid_print
      print("Erro no login $error > $exception");

      return ApiResponse.error("Não foi possivel fazer o login");
    }
  }

  
}

