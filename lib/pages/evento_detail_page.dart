import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:pruebas/utils/extras.dart';
import 'package:pruebas/utils/responsive.dart';

class EventoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final Map post = ModalRoute.of(context).settings.arguments as Map;
    String timestamp = post['date'];
    DateTime date = DateTime.parse(timestamp);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.dark,
            elevation: 3,
            expandedHeight: 250,
            pinned: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                children: <Widget>[
                  Container(
                      child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: post['id'],
                        child: FadeInImage(
                          height: double.infinity,
                          width: double.infinity,
                          placeholder: AssetImage('assets/logo_negro_solo.png'),
                          image: NetworkImage(
                            post['_embedded']['wp:featuredmedia'][0]
                                    ['media_details']['sizes']['medium_large']
                                ['source_url'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              parse((post['title']['rendered']).toString())
                                  .documentElement
                                  .text,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.ip(2.8),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Extras.fromNow(date),
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: responsive.ip(1.9),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              parse((post['content']['rendered']).toString())
                                  .documentElement
                                  .text,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: responsive.ip(1.9),
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
