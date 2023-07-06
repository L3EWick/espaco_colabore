import 'package:colabore/screens/form/form.dart';
import 'package:colabore/screens/form/formview.dart';
import 'package:flutter/material.dart';
import 'package:colabore/screens/utils/drawer_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DataScreen(),
    const FormScreen(),
  ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  
  
  
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: Text("Espaço Colabore"),
            backgroundColor: Colors.deepPurple[800],),
        drawer: DrawerList(),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Página Inicial'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Novo Cadastro'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
    );

  }
}