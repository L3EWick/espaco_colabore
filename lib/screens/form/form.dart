import 'package:colabore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:colabore/screens/utils/url.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
 TextEditingController _tNome      = TextEditingController();
 TextEditingController _tIdade      = TextEditingController();
 TextEditingController _tProfissao  = TextEditingController();
 TextEditingController _tFinalidade = TextEditingController();

postData() async {
  var response = await http.post(
    Uri.parse("http://$link/api/form"),
    body: {
      "nome": _tNome.text,
      "idade": _tIdade.text,
      "profissao": _tProfissao.text,
      "finalidade": _tFinalidade.text,
    },
  );
    print(response.body);
    Navigator.pushReplacement(
      context,
    MaterialPageRoute(builder: (context) => HomeScreen(),
    )
       
    );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

    padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
    child: Container(
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
                    hintText: "Nome" ,
                    icon: Icon(Icons.supervisor_account_sharp)
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _tIdade,
                  decoration: InputDecoration(
                    labelText: "Idade",
                    hintText: "Idade" ,
                    icon: Icon(Icons.add_box_rounded)
                  ),
              ),
              SizedBox(
                height: 10,
              ),TextFormField(
                  controller: _tProfissao,
                  decoration: InputDecoration(
                    labelText: "Profissão",
                    hintText: "Profissão" ,
                    icon: Icon(Icons.adjust)
                  ),
              ),
              SizedBox(
                height: 10,
              ),TextFormField(
                  controller: _tFinalidade,
                  decoration: InputDecoration(
                    labelText: "Finalidade de Acesso",
                    hintText: "Finalidade de Acesso" ,
                    icon: Icon(Icons.apartment_sharp)
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderImagePicker(
                name: 'photos',
                decoration: const InputDecoration(labelText: 'Fotos do Munícipe'),
                maxImages: 1,
              ),
              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: postData, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[800],
                  fixedSize: const Size(150, 46),
                  textStyle: const TextStyle(fontSize: 15),
                ),
                child: Text('Enviar')
              ),
            
            ],
          )
        ],
      ),
    ),
    )
    );
  }
}



