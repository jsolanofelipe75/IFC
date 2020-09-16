import 'package:flutter/material.dart';


final items = <_Item>[
  _Item( 'NUESTRA MISIÓN','Somos una iglesia que amamos a Dios y amamos a las personas, creemos en el diseño de Dios para la familia y estamos comprometidos en la formación de discípulos de Jesús, plantándolos en la casa del Señor.', Colors.transparent,'“Jesús se acercó y dijo a sus discípulos: «Se me ha dado toda autoridad en el cielo y en la tierra. Por lo tanto, vayan y hagan discípulos de todas las naciones, bautizándolos en el nombre del Padre y del Hijo y del Espíritu Santo. Enseñen a los nuevos discípulos a obedecer todos los mandatos que les he dado. Y tengan por seguro esto: que estoy con ustedes siempre, hasta el fin de los tiempos»»Mateo 28:18-20 NTV.'),
  _Item( 'NUESTRA VISIÓN','Compartir las buenas noticias de Cristo en todo lugar, guiando a cada persona a creer en Jesús, para que experimente el poder de Dios, su vida sea transformada y en el nombre de Jesús tenga salvación.', Colors.transparent, '“Pues no me avergüenzo de la Buena Noticia acerca de Cristo, porque es poder de Dios en acción para salvar a todos los que creen.” Romanos 1:16 NTV'),

];

class _Item{

  
  final String title;
  final String description;
  final String pasaje;
  final Color color;

  _Item( this.title, this.description, this.color, this.pasaje);

  
}

