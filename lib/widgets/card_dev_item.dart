import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/models/devocional.dart';


class CardDevItem extends StatelessWidget {

  final Devocional devocional;

  const CardDevItem({@required this.devocional});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, '/devDetail', arguments: devocional);
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            (devocional.imagen != null)
                ? Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: devocional.imagen,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                )
                : Image(
                    image: AssetImage('assets/logo_negro_solo.png'),
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  Text(
                    devocional.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  (devocional.descripcion != null)
                      ? Text(
                          devocional.descripcion,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              TextStyle(fontSize: 11, color: Colors.blueGrey),
                        )
                      : Text('No hay descripción'),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}