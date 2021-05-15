import 'package:flutter/material.dart';
import 'package:flutter_hf/ui/movies/movies_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesPageWidget(),
    );
  }
}
