// import 'package:incidentreport/utils/prefs.dart';
import 'package:colabore/screens/utils/prefs.dart';
import 'dart:convert' as convert;
import 'dart:async';

class Usuario {
  int? id;
  late String nome;
  late String email;
  String? token;

  Usuario({this.id, required this.nome, required this.email, this.token});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['email'] = email;
    data['token'] = token;
    return data;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario?> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty) {
      return null;
    }
    Usuario user = Usuario.fromJson(convert.json.decode(json));
    return user;
  }

  @override
  String toString() {
    return 'Usuario{email: $email, name: $nome, token $token, id: $id}';
  }
}
