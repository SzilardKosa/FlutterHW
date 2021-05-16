import 'package:flutter_hf/domain/model/movie_listitem.dart';

class MovieMemoryDataSource {
  List<MovieListItem> _movies = [];

  void saveMovies(List<MovieListItem> movies) {
    this._movies = movies;
  }

  List<MovieListItem> getMovies() {
    return this._movies;
  }

  List<MovieListItem> getFavorites() {
    return this._movies.where((element) => element.isFavorite).toList();
  }

  void toggleFavorite(int malId) {
    final index = _movies.indexWhere((element) => element.malId == malId);
    if(index == -1) return;
    var movie = _movies[index];
    MovieListItem newMovie = MovieListItem(
        movie.malId,
        movie.title,
        movie.aired,
        movie.score,
        movie.members,
        movie.imageUrl,
        !movie.isFavorite
    );
    _movies[index] = newMovie;
  }

}