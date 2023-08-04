import 'package:colabore/screens/utils/drawer_list.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' ;

class SecretPage extends StatefulWidget {
  const SecretPage({Key? key}) : super(key: key);

  @override
  _SecretPageState createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
 final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://devs.mesquita.rj.gov.br/membros')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://devs.mesquita.rj.gov.br/membros'));

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Equipe de Desenvolvimento Tecnologia PMM')),
    body: WebViewWidget(controller: controller),
    drawer: DrawerList(),
  );
}
  }

