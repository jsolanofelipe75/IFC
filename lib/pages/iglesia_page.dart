import 'package:flutter/material.dart';
import 'package:pruebas/theme/text_theme.dart';

import '../utils/responsive.dart';
import '../widgets/generic_item.dart';

class IglesiaPage extends StatelessWidget {
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
                    Image.asset('assets/Vision.jpg', fit: BoxFit.cover,height: double.infinity,),
                    Center(
                      child: Container(
                        color: Colors.black26,
                        child: Text(
                          'conoce nuestra \nmisión y visión',
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
      ),
    );
  }
}

class _ListaItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, i) => Card(
        elevation: 3,
        child: Container(
          color: items[i].color,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: <Widget>[
                Text(
                  items[i].title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: responsive.ip(2.4),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextThemeSubTitle(
                    text: items[i].description,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    items[i].pasaje,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontSize: responsive.ip(1.7),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
