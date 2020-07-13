import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pruebas/theme/colors.dart';

class WebViewS extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewS> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      initialChild: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
      url: 'https://www.bible.com/es/bible/149/GEN.1.RVR1960',
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: LightColors.kgrey,
        title: Text('Biblia digital'),
      ),
    );
  }
}
