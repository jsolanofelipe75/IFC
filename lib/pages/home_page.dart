import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pruebas/pages/main_page.dart';
import 'package:pruebas/pages/events_page.dart';
import 'package:pruebas/pages/profile_page.dart';
import 'package:pruebas/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Consumer<_NavegacionModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: LightColors.kLightYellow,
          body: value.currentScreen,
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            currentIndex: value.currentPage,
            selectedItemColor: LightColors.kgrey,
            onTap: (int idx) {
              value.currentPage = idx;
            },
            elevation: 20,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), title: Text('Inicio')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.news), title: Text('Eventos')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  title: Text('Perfil')),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _currentPage = 0;
  List<Widget> _screens = [
    HomePrincipal(),
    EventosPage(),
    ProfilePage(),
  ];

  set currentPage(int page) {
    this._currentPage = page;
    notifyListeners();
  }

  get currentPage => this._currentPage;
  get currentScreen => this._screens[this._currentPage];
}
