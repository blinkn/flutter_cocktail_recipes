import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final titleStyle = TxtStyle()
  ..fontFamily('Poppins')
  ..fontWeight(FontWeight.w900)
  ..fontSize(25)
  ..bold()..textAlign.start();

final subtitleStyle = titleStyle.clone()..fontSize(19);

final normalStyle = TxtStyle()..fontFamily('Poppins')..textAlign.justify();

final smallText = TxtStyle()..fontFamily('Poppins')..fontSize(10)..textColor(Colors.grey);
