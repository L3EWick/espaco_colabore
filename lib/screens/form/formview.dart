import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:colabore/screens/utils/url.dart';
import 'package:colabore/screens/form/details_screen.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<dynamic> dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://$link/api/dados'));
    if (response.statusCode == 200) {
      setState(() {
        final decodedData = jsonDecode(response.body);
        dataList = decodedData.map((data) {
          return {
            'nome': data['nome'],
            'idade': data['idade'],
            'profissao': data['profissao'],
            'finalidade': data['finalidade'],
            'photo': data['photo'],
          };
        }).toList();
        isLoading = false;
      });
    } else {
      // Trate o caso de erro na solicitação
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data = dataList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Card(
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(data['nome']),
                        subtitle: Text('Idade: ${data['idade']}'),
                        leading: CircleAvatar(
                          backgroundImage: data['photo'] != null
                              ? NetworkImage(
                                  'http://$link/storage/municipe/${data['photo']}',
                                ) as ImageProvider<Object>?
                              : AssetImage('assets/images/default_avatar.png'),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(data: data),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
