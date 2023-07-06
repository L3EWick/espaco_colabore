import 'package:colabore/screens/utils/url.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailsScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: data['photo'] != null
                        ? NetworkImage('http://$link/storage/municipe/${data['photo']}')
                        : AssetImage('assets/default_avatar.png') as ImageProvider,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Nome: ${data['nome'] ?? ''}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Idade: ${data['idade'] ?? ''}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Profissão: ${data['profissao'] ?? ''}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Finalidade de Acesso: ${data['finalidade'] ?? ''}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
