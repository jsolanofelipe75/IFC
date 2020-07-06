import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pruebas/theme/colors.dart';
import '../utils/responsive.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String id;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences _prefs;
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      id = _prefs.getString('uid');
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              height: 350,
              decoration: BoxDecoration(color: LightColors.kLightYellow2),
            ),
          ),
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 350,
              foregroundDecoration:
                  BoxDecoration(color: LightColors.kDarkYellow.withOpacity(1)),
            ),
          ),
          FutureBuilder(
            future:
                Firestore.instance.collection('usuarios').document(id).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    const SizedBox(
                      height: 90,
                    ),
                    SlideInDown(
                      child: _loadAvatar(
                          snapshot.data['photoUrl'] ?? 'no image',
                          responsive.ip(10)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ZoomIn(
                      child: Text(
                        snapshot.data['name'],
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SlideInUp(
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data['email'],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Telefono: 3186983440',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                snapshot.data['createdAt'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

CircleAvatar _loadAvatar(String image, double radius) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    radius: radius,
    child: CircleAvatar(
      backgroundImage: NetworkImage(image),
      backgroundColor: Colors.white,
      radius: radius - 2,
    ),
  );
}
