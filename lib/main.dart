import 'package:belajar_bloc/network/api.dart';
import 'package:belajar_bloc/ui/home/home_page.dart';
import 'package:flutter/material.dart';

void main({env = "DEV"}) {
  if (env == "PROD") Api.setProduction();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc & Cubit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
