import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/sort_enum.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';
import 'package:flutter_hf/ui/details/details_page.dart';

import '../movie_list_item.dart';

class MoviesPage extends StatefulWidget {
  final MovieInteractor movieInteractor;

  MoviesPage(this.movieInteractor);

  @override
  _MoviesPageState createState() => _MoviesPageState(movieInteractor);
}

class _MoviesPageState extends State<MoviesPage>{
  final MovieInteractor _movieInteractor;
  Future<List<MovieListItem>>? moviesRequest;

  _MoviesPageState(this._movieInteractor);

  @override
  void initState() {
    moviesRequest = _movieInteractor.getMovies();
    super.initState();
  }

  void onPopupMenuItemClicked(SortOptions selected) async {
    await _movieInteractor.setSortOption(selected);
    refreshMovies();
  }

  void onToggleFavorite(MovieListItem movie) async {
    await _movieInteractor.toggleFavorite(movie.malId);
    refreshMovies();
  }

  void refreshMovies() {
    if (mounted) {
      setState(() {
        moviesRequest = _movieInteractor.getMovies();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studio Ghibli movies"),
        actions: [
          PopupMenuButton<SortOptions>(
            onSelected: onPopupMenuItemClicked,
            itemBuilder: (context) {
              return [
                PopupMenuItem<SortOptions>(
                  value: SortOptions.newest,
                  child: Text("Sort by Date")
                ),
                PopupMenuItem<SortOptions>(
                    value: SortOptions.score,
                    child: Text("Sort by Rating")
                ),
                PopupMenuItem<SortOptions>(
                    value: SortOptions.title,
                    child: Text("Sort by Title")
                ),
              ];
            }
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = _movieInteractor.getMovies();
          setState(() {
            moviesRequest = request;
          });
          await request;
        },
        child: FutureBuilder<List<MovieListItem>>(
            future: moviesRequest,
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsPageWidget(_movieInteractor, item.malId)
                          )
                        );
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


