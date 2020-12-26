import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:provider/provider.dart';
import 'package:pruebas/keys/keys.dart';
import 'package:pruebas/provider/radio_stream.dart';
import 'package:pruebas/theme/colors.dart';

import '../routes/routes.dart';
import '../utils/responsive.dart';

class HomePrincipal extends StatefulWidget {
  HomePrincipal({Key key}) : super(key: key);

  @override
  _HomePrincipalState createState() => _HomePrincipalState();
}

playVideo(String video) {
  FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: YT_API_KEY,
      videoUrl: video,
      fullScreen: false,
      appBarColor: Colors.black,
      autoPlay: true);
}

class _HomePrincipalState extends State<HomePrincipal> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.blueGrey,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      sized: true,
      child: ChangeNotifierProvider(
        create: (_) => StreamState(),
        child: Consumer<StreamState>(
          builder: (BuildContext context, StreamState value, Widget child) =>
              Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(
                'assets/logo_negro_solo.png',
                scale: 40,
              ),
            ),
            backgroundColor: Colors.white,
            body: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ZoomIn(
                      child: Center(
                        
                        child: Image.asset(
                          'assets/imag_princ.jpeg',
                          width: double.infinity,
                          height: 270,
                          fit: BoxFit.fill,
                          
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SlideInUp(child: _LoadVerse()),
                    SlideInUp(
                        child: Image.asset(
                      'assets/separator.png',
                      width: 40,
                      height: 40,
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    SlideInUp(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Escucha IFC Radio',
                                style: TextStyle(
                                    fontSize: responsive.ip(2.5),
                                    color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/BLANCO.png',
                                    width: 200,
                                    height: 200,
                                  ),
                                  Positioned(
                                    top: 57,
                                    left: 61,
                                    child: FlatButton(
                                      child: value.isPlaying()
                                          ? Icon(
                                              Icons.stop,
                                              size: 40,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.play_arrow,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                      onPressed: () {
                                        value.isPlaying()
                                            ? value.audioPause()
                                            : value.audioPlay();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SlideInUp(
                        child: Image.asset(
                      'assets/separator.png',
                      width: 40,
                      height: 40,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            'Conoce nuestra agenda semanal.',
                            style: TextStyle(
                                fontSize: responsive.ip(2.5),
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SlideInUp(
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset('assets/main_video.jpg', fit: BoxFit.cover,width: double.infinity,),
                            FlatButton(
                              onPressed: () => playVideo(
                                  'https://youtu.be/Dg5bihwQxLM'),
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('versiculo').doc(day).get(),
      builder: (context, snapShot) {
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
                  Text(snapShot.data.data()['texto'],
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: responsive.ip(1.7),
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    snapShot.data.data()['ref'],
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
        subtitle: Text(
          pageRoutes[i].subtitle,
          style:
              TextStyle(color: Colors.blueGrey, fontSize: responsive.ip(1.7)),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageRoutes[i].page));
        },
      ),
    );
  }
}
