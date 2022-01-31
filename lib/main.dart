
import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/pages/home_page/home_page.dart';
import 'package:flutter_thmdb_app/src/shared/singleton/genre_singleton.dart';

void main() async {
  await GenreSingleton().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   //builder: RequestLoader.initLoading(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}