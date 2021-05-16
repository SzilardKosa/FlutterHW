import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';
import 'package:flutter_hf/ui/list/favorites/favorites_page.dart';
import 'package:flutter_hf/ui/list/movies/movies_page.dart';

class ListPage extends StatefulWidget {
  final MovieInteractor movieInteractor;

  ListPage({Key? key, required this.movieInteractor}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState(movieInteractor);
}

class _ListPageState extends State<ListPage> {
  final MovieInteractor _movieInteractor;
  int _currentIndex = 0;

  _ListPageState(this._movieInteractor);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      MoviesPage(_movieInteractor),
      FavoritesPage(_movieInteractor)
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: "Movies",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites"
          ),
        ],
      ),
    );
  }
}
