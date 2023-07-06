import 'dart:io';
import 'package:colabore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colabore/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();

  TextEditingController _tNome = TextEditingController();
  TextEditingController _tIdade = TextEditingController();
  TextEditingController _tProfissao = TextEditingController();
  TextEditingController _tFinalidade = TextEditingController();

  XFile? _image;
  final picker = ImagePicker();

  bool _isLoading = false;

  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Text("Nenhuma foto Selecionada"),
      );
    } else {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        width: 300,
        height: 300,
      );
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitForm() async {
    if (_addFormKey.currentState!.validate()) {
      _addFormKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      Map<String, String> body = {
        'nome': _tNome.text,
        'idade': _tIdade.text,
        'profissao': _tProfissao.text,
        'finalidade': _tFinalidade.text,
      };
      await service.addImage(body, _image!.path);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: Container(
            child: Form(
              key: _addFormKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        "Novo Cadastro ",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _tNome,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: "Nome",
                          icon: Icon(Icons.supervisor_account_sharp),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _tIdade,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Idade",
                          hintText: "Idade",
                          icon: Icon(Icons.add_box_rounded),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _tProfissao,
                        decoration: InputDecoration(
                          labelText: "Profissão",
                          hintText: "Profissão",
                          icon: Icon(Icons.adjust),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _tFinalidade,
                        decoration: InputDecoration(
                          labelText: "Finalidade de Acesso",
                          hintText: "Finalidade de Acesso",
                          icon: Icon(Icons.apartment_sharp),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Foto do Munícipe ",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: getImage,
                        child: Text("Adicionar Imagem"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: _buildImage(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
