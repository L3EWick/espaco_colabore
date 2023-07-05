import 'package:http/http.dart' as http;
import 'package:colabore/screens/utils/url.dart';


class Service {
Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = '$link/api/form';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('photo', filepath));
var response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}