import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:pruebas/services/wordpress.dart';
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/theme/text_theme.dart';
import 'package:pruebas/widgets/card_event_item.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final postsProvider = PostsProvider();

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
            child: Container(height: 160, color: LightColors.kgrey),
          ),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30.0),
                  child: TextThemeTitle(
                    text: 'Blog',
                    color: Colors.white,
                  ))),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 15, right: 15),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.0,
                      blurRadius: 0.0,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: _crearListado(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: postsProvider.blog(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
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
                Text('Cargando Blog...')
              ],
            ),
          );
        var posts = snapShot.data;
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              Map posts = snapShot.data[index];
              return CardEventItem(post: posts);
            });
      },
    );
  }
}
