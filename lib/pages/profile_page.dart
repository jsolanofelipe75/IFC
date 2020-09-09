import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pruebas/provider/login_state.dart';
import 'package:pruebas/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  BoxDecoration(color: LightColors.kgrey.withOpacity(1)),
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance.collection('usuarios').doc(id).get(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                int timestamp = snapshot.data.data()['createdAt'];
                DateTime date =
                    DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
                String formattedDate = DateFormat.yMMMd().format(date);
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    const SizedBox(
                      height: 90,
                    ),
                    SlideInDown(
                      child: _loadAvatar(
                          snapshot.data.data()['photoUrl'], responsive.ip(10)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ZoomIn(
                      child: Text(
                        snapshot.data.data()['name'],
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
                                "Correo: ${snapshot.data.data()['email']}",
                                style: TextStyle(fontSize: responsive.ip(2.0),color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Telefono: ',
                                style: TextStyle(fontSize: responsive.ip(2.0),color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Miembro desde: $formattedDate',
                                style: TextStyle(fontSize: responsive.ip(2.0),color: Colors.blueGrey),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Center(
                                child: FlatButton(
                                    onPressed: () {
                                      Provider.of<LoginState>(context, listen: false).logout();
                                    },
                                    child: Text('Cerrar sesión',style: TextStyle(fontSize: responsive.ip(2.0),color: Colors.blueGrey),)),
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
  if (image == '') {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/avatar.jpg'),
        backgroundColor: Colors.white,
        radius: radius - 2,
      ),
    );
  } else {
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
}
