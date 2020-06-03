import 'package:flutter/material.dart';


final items = <_Item>[
  _Item( 'NUESTRA MISIÓN ES LA MISIÓN DE DIOS','Somos una iglesia fuerte conformada por familias sanas, con la misión de hacer discipulos y proezas. Mateo 28:18-20', Color.fromRGBO(161, 0, 98, 1)),
  _Item( 'NUESTRA VISIÓN ES LA VISIÓN DE DIOS','Anunciar valientemente la buena noticia del evangelio con poder de Dios a todas las familias, para que en Jesús sean salvas. Romanos 1:16', Color.fromRGBO(216, 0, 56, 1)),

];

class _Item{

  
  final String title;
  final String description;
  final Color color;

  _Item( this.title, this.description, this.color);

  
}