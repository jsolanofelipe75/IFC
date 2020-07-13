import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import 'package:pruebas/utils/responsive.dart';

class CardEventItem extends StatelessWidget {
  final Map post;

  const CardEventItem({@required this.post});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, '/eventoDetail', arguments: post);
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Hero(
              tag: post['id'],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: AssetImage('assets/face.jpg'),
                  image: NetworkImage(post['_embedded']['wp:featuredmedia'][0]
                      ['media_details']['sizes']['medium_large']['source_url']),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  Text(
                    parse((post['title']['rendered']).toString())
                        .documentElement
                        .text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: responsive.ip(2.0),
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.start,
                  ),
                 
                  (post['excerpt']['rendered'] != null)
                      ? Text(
                          parse((post['content']['rendered']).toString())
                              .documentElement
                              .text,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: responsive.ip(1.6),
                              color: Colors.blueGrey),
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
