import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';
import 'package:flutter_hf/ui/details/details_page.dart';
import 'package:flutter_hf/ui/list/movie_list_item.dart';

class FavoritesPage extends StatefulWidget {
  final MovieInteractor movieInteractor;

  FavoritesPage(this.movieInteractor);

  @override
  _FavoritesPageState createState() => _FavoritesPageState(movieInteractor);
}

class _FavoritesPageState extends State<FavoritesPage>{
  final MovieInteractor _movieInteractor;
  Future<List<MovieListItem>>? favoritesRequest;

  _FavoritesPageState(this._movieInteractor);

  @override
  void initState() {
    favoritesRequest = _movieInteractor.getFavorites();
    super.initState();
  }

  void onToggleFavorite(MovieListItem movie) {
    _movieInteractor.toggleFavorite(movie.malId);
    refreshMovies();
  }

  void refreshMovies([Function? beforeRefresh]) {
    if (mounted) {
      setState(() {
        if (beforeRefresh != null) beforeRefresh();
        favoritesRequest = _movieInteractor.getFavorites();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = _movieInteractor.getFavorites();
          setState(() {
            favoritesRequest = request;
          });
          await request;
        },
        child: FutureBuilder<List<MovieListItem>>(
            future: favoritesRequest,
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(
                  child: Text(
                      "An error occurred: ${snapshot.error}"
                  ),
                );
              }

              if (snapshot.hasData){
                var movies = snapshot.data!;
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, i){
                    return ListItem(
                      movies[i],
                      onToggleFavorite: (movie) => onToggleFavorite(movie),
                      onTap: (item) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailsPageWidget(_movieInteractor, item.malId)));
                      },
                    );
                  },
                  itemCount: movies.length,
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
      ),
    );
  }
}


