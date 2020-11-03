import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoWindowWidget extends StatelessWidget {
  const InfoWindowWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
        Container(width: 20,
        height: 10,
        color: Colors.red)],
    );
  }
}