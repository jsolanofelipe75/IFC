import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pruebas/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'Contacto',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(3.0)),
          )),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.directions),
            title: Text('Dirección',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.2))),
            subtitle: Text(
                'Carrera 9Bs #2N23 Barrio: Villa Paula \nPopayán Cauca',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.0))),
          ),
          ListTile(
            leading: Icon(Icons.settings_cell),
            title: Text('Teléfono',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.2))),
            subtitle: Text('3046779707, 3154114471',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.0))),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Correo',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.2))),
            subtitle: Text('contacto@iglesiafamiliarcristiana.org',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: responsive.ip(2.0))),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Visítanos en nuestras redes sociales y página web',
              style: TextStyle(
                  fontSize: responsive.ip(2.1),),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.facebook.com/IglesiaFamiliarCristianaIFC');
                    },
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blueAccent,
                      size: responsive.ip(4.0),
                    ),
                  ),
                  Text(
                    'Facebook',
                    style: TextStyle(fontSize: responsive.ip(1.3)),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.instagram.com/iglesia_familiar_cristiana_ifc/?hl=es-la');
                    },
                    child: Icon(
                      FontAwesomeIcons.instagram,
                      size: responsive.ip(4.0),
                    ),
                  ),
                  Text(
                    'Instagram',
                    style: TextStyle(fontSize: responsive.ip(1.3)),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.youtube.com/channel/UC31EA4cMrAavsIcafmuebnA');
                    },
                    child: Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.redAccent,
                      size: responsive.ip(4.0),
                    ),
                  ),
                  Text(
                    'Youtube',
                    style: TextStyle(fontSize: responsive.ip(1.3)),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _launchURL('https://iglesiafamiliarcristiana.org/');
                    },
                    child: Icon(
                      FontAwesomeIcons.internetExplorer,
                      size: responsive.ip(4.0),
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    'Web',
                    style: TextStyle(fontSize: responsive.ip(1.3)),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
      bottomNavigationBar: ListTile(
        leading: Icon(FontAwesomeIcons.mobile),
        title: Text('Diseñado por Felipe Solano para la IFC',
            style: TextStyle(
                color: Colors.black, fontSize: responsive.ip(1.7))),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
