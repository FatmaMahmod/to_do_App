import 'package:flutter/material.dart';
import 'package:untitled4/layout/home_layout.dart';
import 'package:untitled4/modules/counter/counter.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Counter(),
    );
  }

}
