import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/pages/devoc_page.dart';
import 'package:pruebas/pages/events_page.dart';
import 'package:pruebas/pages/iglesia_page.dart';
import 'package:pruebas/pages/videos_page.dart';
import 'package:pruebas/pages/bible_page.dart';
import 'package:pruebas/pages/profile_page.dart';


final pageRoutes = <_Route>[
  _Route(CupertinoIcons.info, 'Nuestra iglesia','Conoce nuestra misión, visión ...', IglesiaPage(), Colors.purple),
  _Route(CupertinoIcons.news_solid, 'Eventos','Entérate de los eventos que tenemos para ti', EventosPage(), Colors.orange),
  _Route(CupertinoIcons.video_camera_solid, 'Predicas','Predicas disponibles en nuestro canal de Youtube', VideosListPage(), Colors.blue),
  _Route(CupertinoIcons.book_solid, 'Biblia digital','Corresponde a la versión web de YouVersion' ,WebViewS(), Colors.redAccent),
  _Route(CupertinoIcons.bookmark_solid, 'Devocionales','Revisa los devocionales que tenemos para ti', DevocionalesPage(), Colors.green),
  _Route(Icons.home, 'Altar Familiar','Cada casa como un altar de adoración', ProfilePage(), Colors.blueGrey),

];

class _Route{

  final IconData icon;
  final String titulo;
  final String subtitle;
  final Widget page;
  final Color color;

  _Route(this.icon, this.titulo, this.subtitle, this.page, this.color);

  
}