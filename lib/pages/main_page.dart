import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import 'package:pruebas/provider/login_state.dart';
import 'package:pruebas/theme/colors.dart';
import '../routes/routes.dart';
import '../utils/responsive.dart';

class HomePrincipal extends StatefulWidget {
  HomePrincipal({Key key}) : super(key: key);

  @override
  _HomePrincipalState createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/logo_negro_solo.png',
          scale: 40,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Provider.of<LoginState>(context, listen: false).logout();
            },
            color: Colors.black,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      width: responsive.width,
                      decoration: BoxDecoration(
                        color: LightColors.kDarkYellow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Iglesia',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.ip(3.5)),
                              
                            ),
                            Text(
                              'Familiar Cristiana',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.ip(3.5)),
                              
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: LightColors.kgrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, right: 3.0),
                                child: Text(
                                  ' EN DIOS HAREMOS PROEZAS ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: responsive.ip(2.3)),
                                ),
                              ),
                          
                            ),
                            SizedBox(height: responsive.hp(6.5),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SlideInUp(child: _LoadVerse()),
              SizedBox(
                height: 20,
              ),
              SlideInUp(
                  child: Column(
                children: <Widget>[
                  Container(child: _ListaOpciones()),
                ],
              )),
            ],
          );
        },
      ),
    );
  }
}

class _LoadVerse extends StatefulWidget {
  @override
  _LoadVerseState createState() => _LoadVerseState();
}

class _LoadVerseState extends State<_LoadVerse> {
  String day = '1';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final DateTime now = DateTime.now();
    final diff = DateTime.now().difference(DateTime(now.year, 1, 1, 0, 0));

    setState(() {
      day = diff.inDays.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return FutureBuilder(
      future: Firestore.instance.collection('versiculo').document('1').get(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        if (!snapShot.hasData) {
          return CupertinoActivityIndicator();
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: LightColors.kLightYellow2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Versiculo del día',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: responsive.ip(2.6),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(snapShot.data['texto'],
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: responsive.ip(1.8),
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Genesis 1  2',
                    style: TextStyle(
                        fontSize: responsive.ip(2),
                        color: LightColors.kgrey,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(
          backgroundColor: pageRoutes[i].color,
          child: Icon(
            pageRoutes[i].icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          pageRoutes[i].titulo,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LightColors.kgrey,
              fontSize: responsive.ip(2),
          ),
        ),
        subtitle: Text(pageRoutes[i].subtitle,
            style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(1.8)),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
