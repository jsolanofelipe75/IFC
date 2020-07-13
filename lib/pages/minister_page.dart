import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pruebas/utils/responsive.dart';

class MinisterPage extends StatefulWidget {
  MinisterPage({Key key}) : super(key: key);

  @override
  _MinisterPageState createState() => _MinisterPageState();
}

class _MinisterPageState extends State<MinisterPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.dark,
              elevation: 3,
              expandedHeight: 180,
              pinned: false,
              floating: false,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/Vision.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                    Center(
                      child: Container(
                        color: Colors.black26,
                        child: Text(
                          'Ministerios',
                          style: TextStyle(
                              fontSize: responsive.ip(3.5),
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _ListaItems(),
              ]),
            )
          ],
        ));
  }
}

class _ListaItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/ministerios.json'),
      builder: (context, snapshot) {
        var showdata = jsonDecode(snapshot.data.toString());
         if (!snapshot.hasData)
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
                Text('Cargando...')
              ],
            ),
          );
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) => Card(
            elevation: 3,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      showdata[i]["title"],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.ip(2.4),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.network(showdata[i]["image"], width: double.infinity, height: 200,),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        showdata[i]["description"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: responsive.ip(1.8),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemCount: showdata.length,
        );
      },
    );
  }
}
