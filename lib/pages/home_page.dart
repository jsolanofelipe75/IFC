import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas/pages/events_page.dart';
import 'package:pruebas/pages/main_page.dart';
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
          backgroundColor: Colors.white,
          body: value.currentScreen,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(CupertinoIcons.mail_solid, color: Colors.white,),
            elevation: 3,
            tooltip: 'DONAR',
            backgroundColor: LightColors.kgrey,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BubbleBottomBar(
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                  backgroundColor: LightColors.kgrey,
                  icon: Icon(
                    CupertinoIcons.home,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.home,
                    color: LightColors.kgrey,
                  ),
                  title: Text("Inicio")),
              BubbleBottomBarItem(
                  backgroundColor: LightColors.kgrey,
                  icon: Icon(
                    CupertinoIcons.conversation_bubble,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.conversation_bubble,
                    color: LightColors.kgrey,
                  ),
                  title: Text("Blog")),
              BubbleBottomBarItem(
                  backgroundColor: LightColors.kgrey,
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.profile_circled,
                    color: LightColors.kgrey,
                  ),
                  title: Text("Perfil")),
            ],
            opacity: .2,
            currentIndex: value.currentPage,
            onTap: (int idx) {
              value.currentPage = idx;
            },
            elevation: 8,
            hasInk: true,
            hasNotch: true,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            fabLocation: BubbleBottomBarFabLocation.end,
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
