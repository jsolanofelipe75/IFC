import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pruebas/pages/blog_page.dart';
import 'package:pruebas/pages/main_page.dart';
import 'package:pruebas/pages/profile_page.dart';
import 'package:pruebas/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Consumer<_NavegacionModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.white,
          body: value.currentScreen,
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
            elevation: 10,
            hasInk: true,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
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
    BlogPage(),
    ProfilePage(),
  ];

  set currentPage(int page) {
    this._currentPage = page;
    notifyListeners();
  }

  get currentPage => this._currentPage;

  get currentScreen => this._screens[this._currentPage];
}
