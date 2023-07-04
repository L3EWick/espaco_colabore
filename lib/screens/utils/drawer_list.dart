// import 'package:colabore/screens/login/login_api.dart';
import 'package:colabore/screens/login/usuario.dart';
import 'package:colabore/screens/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:colabore/screens/home_page.dart';
import 'package:colabore/screens/login/login_page.dart';
import 'dart:async';

class DrawerList extends StatelessWidget {
  
  const DrawerList({Key? key}) : super(key: key);

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      
      decoration: const BoxDecoration(
        
          gradient:
              LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF4A148C)])),
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
         currentAccountPicture: CircleAvatar(
          child: Image.asset('assets/img/logo.png')),
      
    );
  }
// 0xFF1A237E
  @override
  Widget build(BuildContext context) {
    Future<Usuario?> future = Usuario.get();

    return SafeArea(
      
      child: Drawer(
        child: ListView(
          children: <Widget>[
             
            FutureBuilder<Usuario?>(
              future: future,
              builder: (context, snapshot) {
                Usuario? user = snapshot.data;
                
                // ignore: unnecessary_null_comparison
                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
              title: const Text("Principal"),
              trailing: const Icon(Icons.home),
              onTap: () => _onClickChangeHome(context),
            ),
          // ListTile(
          //     title: const Text("Trocar senha"),
          //     trailing: const Icon(Icons.lock),
          //     onTap: () => _onClickChange(context),
          //   ),
            ListTile(
              title: const Text("Sair"),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }
}
_onClickChangeHome(BuildContext context) {
  Navigator.pop(context);
  push(context, const HomeScreen(), replace: true);
}
// _onClickChange(BuildContext context) {
//   Navigator.pop(context);
//   push(context, const ResetPage(), replace: true);
// }
_onClickLogout(BuildContext context) {
  Usuario.clear();
  Navigator.pop(context);
  push(context, const LoginPage(), replace: true);
}



