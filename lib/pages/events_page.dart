import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pruebas/models/event.dart';
import 'package:pruebas/services/db.dart' as db;
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/theme/text_theme.dart';

import 'package:pruebas/widgets/card_event_item.dart';

class EventosPage extends StatefulWidget {
  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              color: LightColors.kLightYellow2,
              height: 180,
              width: double.infinity,
            ),
          ),
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(height: 140, color: LightColors.kDarkYellow),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 50, top: 35.0),
            child: TextThemeTitle(text: 'Eventos', color: Colors.white,)
          )),
          Padding(
            padding: EdgeInsets.only(
              top: 120,
              left: 15,
              right: 15
            ),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: _crearListado(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearListado() {
    return StreamBuilder(
      stream: db.getEvents(),
      builder: (BuildContext context, AsyncSnapshot<List<Evento>> snapShot) {
        if (snapShot.hasError) {
          return Center(child: Text(snapShot.error.toString()));
        }
        if (!snapShot.hasData)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoActivityIndicator(
                  radius: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Cargando eventos...')
              ],
            ),
          );
        List<Evento> eventos = snapShot.data;
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            final Evento evento = eventos[index];
            return CardEventItem(evento: evento);
          },
        );
      },
    );
  }
}
