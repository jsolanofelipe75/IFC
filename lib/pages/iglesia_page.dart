import 'package:flutter/material.dart';
import '../widgets/generic_item.dart';

class IglesiaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
           SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 150,
            pinned: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only( left: 15, right: 15),
                child: Center(child: Text('Nuestra Iglesia',style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
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
    return ListView.builder(padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, i) => Container(
        height: 200,
       color: items[i].color,
        child: Column(
          children: <Widget>[
            Text(items[i].title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text(items[i].description, style: TextStyle(color: Colors.white),)
          ],
        ),

      ),
    );
  }
}