import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pruebas/models/devocional.dart';
import 'package:pruebas/services/db.dart' as db;
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/widgets/card_dev_item.dart';

class DevocionalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text(
              'Devocionales',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )),
          Padding(padding: EdgeInsets.only(top: 100), child: _crearListado()),
        ],
      ),
    );
  }
}

Widget _crearListado() {
  return StreamBuilder(
    stream: db.getDevocionals(),
    builder: (BuildContext context, AsyncSnapshot<List<Devocional>> snapShot) {
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
              Text('Cargando devocionales...')
            ],
          ),
        );
      List<Devocional> devs = snapShot.data;
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: devs.length,
        itemBuilder: (context, index) {
          final Devocional dev = devs[index];
          return CardDevItem(devocional: dev);
        },
      );
    },
  );
}
