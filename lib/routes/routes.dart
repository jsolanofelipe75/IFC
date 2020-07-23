import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/pages/contact_page.dart';
import 'package:pruebas/pages/bible_page.dart';
import 'package:pruebas/pages/iglesia_page.dart';
import 'package:pruebas/pages/minister_page.dart';
import 'package:pruebas/pages/videos_page.dart';



final pageRoutes = <_Route>[
  _Route(CupertinoIcons.info, 'Nuestra iglesia','Conoce nuestra misión, visión ...', IglesiaPage(), Colors.purple),
  _Route(CupertinoIcons.group_solid, 'Ministerios','En la Iglesia Familiar Cristiana contamos con...', MinisterPage(), Colors.orange),
  _Route(CupertinoIcons.video_camera_solid, 'Predicas','Predicas disponibles en nuestro canal de Youtube', VideosListPage(), Colors.blue),
  _Route(CupertinoIcons.book_solid, 'Biblia digital','Cargado de la versión web de YouVersion' ,WebViewS(), Colors.redAccent),
  _Route(CupertinoIcons.phone_solid, 'Contacto','Revisa los devocionales que tenemos para ti', ContactPage(), Colors.green),
 

];

class _Route{

  final IconData icon;
  final String titulo;
  final String subtitle;
  final Widget page;
  final Color color;

  _Route(this.icon, this.titulo, this.subtitle, this.page, this.color);

  
}