import 'dart:ui';

import 'package:flutter/material.dart';

class Badge extends StatelessWidget {

  final Color color;
  final Widget child;
  final EdgeInsets padding;

  Badge({@required this.child, this.color, this.padding});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 6, horizontal: 9),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: child,

    );
  }
}
