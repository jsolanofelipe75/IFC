import 'package:flutter/material.dart';

import 'package:pruebas/theme/colors.dart';
import '../widgets/generic_item.dart';
import '../utils/responsive.dart';

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
            backgroundColor: LightColors.kDarkYellow,
            expandedHeight: 150,
            pinned: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                      child: Container(
                    child: Text(
                      'conoce nuestra \nmisión y visión',
                      style: TextStyle(
                          fontSize: responsive.ip(4),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ))),
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
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, i) => Container(
        height: 300,
        color: items[i].color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: <Widget>[
              Text(
                items[i].title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                items[i].description,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
