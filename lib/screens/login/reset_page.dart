import 'package:flutter/material.dart';
import 'package:colabore/screens/utils/drawer_list.dart';
import 'package:flutter/rendering.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _NewSenha = TextEditingController();
  final _OldSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("BCI"),
            backgroundColor: Colors.deepPurple[800]),
        drawer: DrawerList(),
        body: Container(
            padding: EdgeInsets.all(16),
            child: ListView(children: <Widget>[
              Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/img/logo.png')
              ),
              Form(
                  key: _formKey,
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          
                          Text(
                            'Alteração de Senha',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 45,
                              child: TextFormField(
                                controller: _OldSenha,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Digite sua antiga senha senha"),
                              )),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            child: TextFormField(
                              controller: _NewSenha,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: "Digite sua nova senha"),
                            ),
                          ),
                           const SizedBox(height: 25),
                        Container(
                          height: 45,
                          margin: const EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width / 1.2,
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            onPressed:(){} ,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[900],
                                fixedSize: const Size(240, 46),
                                textStyle: const TextStyle(fontSize: 22)),
                            child: Text('Enviar'),
                         )),
                        ],
                      )))
            ])));
  }
}
