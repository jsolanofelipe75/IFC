import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/models/event.dart';

class CardEventItem extends StatelessWidget {
  final Evento evento;

  const CardEventItem({@required this.evento});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, '/eventoDetail', arguments: evento);
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            (evento.imagen != null)
                ? Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: evento.id,
                        child: CachedNetworkImage(
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: evento.imagen,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
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
                    evento.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8),
                  (evento.descripcion != null)
                      ? Text(
                          evento.descripcion,
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
