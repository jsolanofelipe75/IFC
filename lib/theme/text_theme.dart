import 'package:flutter/material.dart';

import 'package:pruebas/utils/responsive.dart';

class TextThemeTitle extends StatelessWidget {
  final String text;
  final Color color;

  const TextThemeTitle({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Text(
      this.text,
      maxLines: 1,
      style: TextStyle(
          fontSize: responsive.ip(2.4),
          fontWeight: FontWeight.bold,
          color: color),
    );
  }
}

class TextThemeSubTitle extends StatelessWidget {
  final String text;
  final Color color;

  const TextThemeSubTitle({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Text(
      this.text,
      style: TextStyle(
          fontSize: responsive.ip(1.7),
          fontWeight: FontWeight.normal,
          color: color),
    );
  }
}
