import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/pages/Ifc_tab_page.dart';
import 'package:pruebas/pages/ifckids_tab_page.dart';

class VideosListPage extends StatefulWidget {
  VideosListPage({Key key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Image.asset(
                'assets/logo_negro_solo.png',
                scale: 55,
              )),
              Tab(
                  icon: Image.asset(
                'assets/IFCKIDS.png',
                scale: 60,
              )),
            ],
          ),
          title: Image.asset(
            'assets/ifc_en_casa.png',
            scale: 40,
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [IfcTabPage(), IfcKidsTabPage()],
        ),
      ),
    );
  }
}
