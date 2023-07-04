import 'package:flutter/material.dart';
import 'package:colabore/screens/utils/drawer_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: Text("Colabore"),
            backgroundColor: Colors.deepPurple[800],),
        drawer: DrawerList(),
    );
  }
}