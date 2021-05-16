import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/interactor_provider.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';
import 'package:flutter_hf/ui/list/list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final interactor = MovieInteractor();

  runApp(
    InteractorProvider(
      interactor: interactor,
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(
        movieInteractor: InteractorProvider.of(context)!.interactor,
      ),
    );
  }
}
