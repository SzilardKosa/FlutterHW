import 'package:flutter_hf/data/memory/movie_memory_data_source.dart';
import 'package:flutter_hf/data/network/movie_network_data_source.dart';
import 'package:flutter_hf/data/shared_prefs/movie_shared_prefs.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';
import 'package:flutter_hf/domain/model/sort_enum.dart';


class MovieInteractor {
  var _movieNetworkDataSource = MovieNetworkDataSource();
  var _movieMemoryDataSource = MovieMemoryDataSource();
  var _movieSharedPrefs = MovieSharedPrefs();

  Future<List<MovieListItem>> getMovies() async {

    // get from cache
    List<MovieListItem> movies = _movieMemoryDataSource.getMovies();

    if(movies.isEmpty) {
      // get from network
      movies = await _movieNetworkDataSource.getMovies("start_date", "desc");
      // save to cache
      _movieMemoryDataSource.saveMovies(movies);
      // set favorites from shared prefs
      var favorites = await _movieSharedPrefs.getFavorites();
      for (var fav in favorites) {
        _movieMemoryDataSource.toggleFavorite(int.parse(fav));
      }
    }

    return sortMovies(movies);
  }

  Future<List<MovieListItem>> getFavorites() async {
    // get from cache
    final favorites = _movieMemoryDataSource.getFavorites();
    return sortMovies(favorites);
  }

  Future<void> toggleFavorite(int malId) async {
    await _movieSharedPrefs.toggleFavorite(malId);
    _movieMemoryDataSource.toggleFavorite(malId);
  }

  Future<MovieDetails> getDetails(int malId) async {
    return await _movieNetworkDataSource.getDetails(malId);
  }

  Future<List<MovieListItem>> sortMovies(List<MovieListItem> movies) async{
    final sortOption = await _movieSharedPrefs.getSortOption();

    switch (sortOption){
      case SortOptions.title:
        return movies..sort((a, b) => a.title.compareTo(b.title));
      case SortOptions.score:
        return movies..sort((a, b) => b.score.compareTo(a.score));
      case SortOptions.newest:
        return movies..sort((a, b) => b.aired.compareTo(a.aired));
      default:
        return movies..sort((a, b) => b.aired.compareTo(a.aired));
    }
  }

  Future<void> setSortOption(SortOptions newSortOption) async {
    await _movieSharedPrefs.setSortOption(newSortOption);
  }
}