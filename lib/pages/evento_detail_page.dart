import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:pruebas/utils/responsive.dart';

class EventoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final Map post = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.5,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Hero(
            tag: post['id'],
            child: FadeInImage(
              height: 250,
              placeholder: AssetImage('assets/logo_negro_solo.png'),
              image: NetworkImage(
                post['_embedded']['wp:featuredmedia'][0]['media_details']
                    ['sizes']['medium_large']['source_url'],
              ),
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            parse((post['title']['rendered']).toString()).documentElement.text,
                            style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(2.4), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            parse((post['content']['rendered']).toString()).documentElement.text,
                            style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(1.9), fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
