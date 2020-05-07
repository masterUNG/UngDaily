import 'package:flutter/material.dart';
import 'package:ungdaily/screens/authen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'Ung Daily',
      home: Authen(),
    );
  }
}
