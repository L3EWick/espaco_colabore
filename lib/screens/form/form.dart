import 'dart:io';
import 'package:colabore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colabore/services.dart';
// import 'dart:convert';
// import 'dart:io';

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

  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
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

// postData() async {

//   var response = await http.post(
//     Uri.parse("http://$link/api/form"),
//     body: {
//       "nome": _tNome.text,
//       "idade": _tIdade.text,
//       "profissao": _tProfissao.text,
//       "finalidade": _tFinalidade.text,
//       "photo" : ""
//     },
//   );
//     print(response.body);

//     );

// }
  @override
  Widget build(BuildContext context) {
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
                        icon: Icon(Icons.supervisor_account_sharp)),
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
                        icon: Icon(Icons.add_box_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tProfissao,
                    decoration: InputDecoration(
                        labelText: "Profissão",
                        hintText: "Profissão",
                        icon: Icon(Icons.adjust)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _tFinalidade,
                    decoration: InputDecoration(
                        labelText: "Finalidade de Acesso",
                        hintText: "Finalidade de Acesso",
                        icon: Icon(Icons.apartment_sharp)),
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
                  // ElevatedButton(
                  //   onPressed: (){},
                  //   child: Icon(Icons.add),
                  // ),
        
                  ElevatedButton(
                    onPressed: getImage, 
                    child:
                      _buildImage(),
                  
                  ),
                  const SizedBox(
                    height: 40,
                  ),
        
                  ElevatedButton(
                    onPressed: () {
                      if (_addFormKey.currentState!.validate()) {
                        _addFormKey.currentState!.save();
                        Map<String, String> body = {
                          'nome': _tNome.text,
                          'idade': _tIdade.text,
                          'profissao': _tProfissao.text,
                          'finalidade': _tFinalidade.text
                        };
                        service.addImage(body, _image!.path);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      }
                    },
                    child: Text('Enviar', style: TextStyle(color: Colors.white)),
                  ),
        
                  // ElevatedButton(
                  //   onPressed: (){},
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.indigo[800],
                  //     fixedSize: const Size(150, 46),
                  //     textStyle: const TextStyle(fontSize: 15),
                  //   ),
                  //   child: Text('Enviar')
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
