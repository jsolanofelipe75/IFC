import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pruebas/utils/responsive.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Center(child: Text('Contacto', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: responsive.ip(3.0)),)),
          SizedBox(height: 20,),
          ListTile(leading: Icon(Icons.directions), title: Text('Dirección',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.2))), subtitle: Text('Carrera 9Bs #2N23 Barrio: Villa Paula \nPopayán Cauca',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.0))),),
          ListTile(leading: Icon(Icons.settings_cell), title: Text('Teléfono',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.2))), subtitle: Text('+57 3046779707',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.0))),),
          ListTile(leading: Icon(Icons.mail), title: Text('Correo',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.2))), subtitle: Text('contacto@iglesiafamiliarcristiana.org',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.0))),),
        ],
      ),
      bottomNavigationBar: ListTile(leading: Icon(FontAwesomeIcons.android), title: Text('Diseñado con ❤️ por Felipe Solano para la IFC',style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.2))),),
    );
  }
}