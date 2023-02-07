import 'package:flutter_application_1/admin/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: MyRoute.generateRoute,
      initialRoute: MyRoute.homeRoute,
    );
  }
}
