import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas/provider/login_state.dart';
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/utils/video_player.dart';

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
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
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
                  
                  Container(
                      width: responsive.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            
                            Center(child: Image.asset('assets/large2020.png',width: double.infinity,height: 250,fit: BoxFit.cover,)),
                            
                            
                          ],
                        ),
                      
                    ),
                  
                ],
              ),
              
              
              SizedBox(
                height: 10,
              ),
              SlideInUp(child: _LoadVerse()),
              
              SlideInUp(child: Image.asset('assets/separator.png', width: 40, height: 40,)),
              SizedBox(
                height: 10,
              ),
              SlideInUp(child: Container(color: Colors.white,child: VideoPlayerIFC(), height: 200,width: double.infinity,)),
              SizedBox(
                height: 20,
              ),
              SlideInUp(child: Text('Creemos en Jesús, nuestro Señor y Salvador.', style: TextStyle(fontSize: responsive.ip(1.5), fontStyle: FontStyle.italic),)),
              SizedBox(
                height: 10,
              ),
              SlideInUp(child: Image.asset('assets/separator.png',width: 40, height: 40,)),
              SizedBox(
                height: 10,
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
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Versiculo del día',
                    style: TextStyle(
                      color: LightColors.kgrey,
                      fontSize: responsive.ip(2.4),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(snapShot.data['texto'],
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: responsive.ip(1.7),
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
            style: TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(1.7)),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
