import 'package:flutter/material.dart';
import 'package:colabore/screens/home_page.dart';
import 'package:colabore/screens/login/login_api.dart';
import 'package:colabore/screens/login/usuario.dart';
import 'package:colabore/screens/api_response.dart';
import 'package:colabore/screens/utils/alert.dart';
import 'package:colabore/screens/utils/nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    Future<Usuario?> future = Usuario.get();
    future.then((Usuario? user) {
      if (user != null) {
        push(context, HomeScreen(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Espaço Colabore"),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: Image.asset('assets/img/logo.png'),
            ),
            Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      child: TextFormField(
                        controller: _tLogin,
                        decoration: const InputDecoration(hintText: "Email"),
                        validator: (value) =>
                            value!.isEmpty ? "Preencha o email" : null,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      child: TextFormField(
                        controller: _tSenha,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "Senha"),
                        validator: (value) =>
                            value!.isEmpty ? "Preencha a senha" : null,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      // child: Padding(
                      //   padding: EdgeInsets.only(top: 10, right: 32),
                      //   child: Text(
                      //     'Esqueci Minha Senha',
                      //     style: TextStyle(color: Colors.grey),
                      //   ),
                      // ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: ElevatedButton(
                        onPressed: _showProgress ? null : _onClickLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[900],
                          fixedSize: const Size(240, 46),
                          textStyle: const TextStyle(fontSize: 22),
                        ),
                        child: _showProgress
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : Text('Login'),
                      ),
                    )

                  ],
                ),
              ),
            ),
            Container(
              width: 90,
              height: 90,
              child: Image.asset('assets/img/mesquita_360.png'),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState!.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(login, senha);
    if (response.ok) {
      // ignore: unused_local_variable
      Usuario user = response.result;
      push(context, HomeScreen(), replace: true);
    } else {
      alert(context, response.msg, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }
}
