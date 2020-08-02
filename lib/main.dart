import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:pruebas/pages/evento_detail_page.dart';
import 'package:pruebas/pages/home_page.dart';
import 'package:pruebas/pages/login_page.dart';
import 'package:pruebas/provider/login_state.dart';
import 'package:pruebas/provider/radio_stream.dart';
import 'package:pruebas/theme/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: LightColors.kgrey,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        
      ),
      sized: true,
          child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
              create: (BuildContext context) => LoginState()),
          ChangeNotifierProvider<StreamState>(
              create: (BuildContext context) => StreamState()),
        ],
        child: MaterialApp(
          title: 'IFC',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: LightColors.kgrey,
            accentColor: LightColors.kLightYellow,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: LightColors.kDarkBlue,
                displayColor: LightColors.kDarkBlue,
                fontFamily: 'Poppins'),
          ),
          routes: {
            '/': (BuildContext context) {
              var state = Provider.of<LoginState>(context);
              if (state.isLoggedIn()) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
            '/eventoDetail': (context) => EventoDetailPage(),
          },
        ),
      ),
    );
  }
  
}
