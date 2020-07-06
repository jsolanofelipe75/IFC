import 'package:flutter/material.dart';


final items = <_Item>[
  _Item( 'NUESTRA MISIÓN ES LA MISIÓN DE DIOS','Somos una iglesia fuerte conformada por familias sanas, con la misión de hacer discipulos y proezas. Mateo 28:18-20', Colors.transparent,'18 Jesús se acercó y dijo a sus discipulos: <<Se me ha dado toda autoridad en el cielo y en la tierra. 19 Por lo tanto, vayan y hagan discipulos a todas las naciones, bautizandolos en el nombre del Padre y del Hijo y del Espíritu santo. 20 Enseñen a los nuevos discipulos a obedecer todos los mandatos que les he dado. Y tengan por seguro esto: que estoy con ustedes siempre, hasta el fin de los tiempos>> Mateo 28: 18- 20'),
  _Item( 'NUESTRA VISIÓN ES LA VISIÓN DE DIOS','Anunciar valientemente la buena noticia del evangelio con poder de Dios a todas las familias, para que en Jesús sean salvas. Romanos 1:16', Colors.transparent, 'No me da verguenza anunciar esta buena noticia. Gracias al poder de Dios, todos los que la escuchany creen en Jesús son salvados; no importa si son juíos o no lo son. Romanos 1:16'),

];

class _Item{

  
  final String title;
  final String description;
  final String pasaje;
  final Color color;

  _Item( this.title, this.description, this.color, this.pasaje);

  
}