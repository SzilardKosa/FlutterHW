import 'package:flutter/material.dart';
import 'package:flutter_hf/ui/list/favorites/favorites_page.dart';
import 'package:flutter_hf/ui/list/movies/movies_page.dart';
import 'package:provider/provider.dart';


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      MoviesPage(Provider.of(context)),
      FavoritesPage(Provider.of(context))
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
