import 'package:flutter_hf/data/memory/movie_memory_data_source.dart';
import 'package:flutter_hf/data/network/movie_network_data_source.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';
import 'package:flutter_hf/domain/model/sort_enum.dart';


class MovieInteractor {
  var _movieNetworkDataSource = MovieNetworkDataSource();
  var _movieMemoryDataSource = MovieMemoryDataSource();
  SortOptions sortOption = SortOptions.newest;

  Future<List<MovieListItem>> getMovies() async {

    // get from cache
    List<MovieListItem> movies = _movieMemoryDataSource.getMovies();

    if(movies.isEmpty) {
      // get from network
      movies = await _movieNetworkDataSource.getMovies("start_date", "desc");
      // save to cache
      _movieMemoryDataSource.saveMovies(movies);
    }

    return sortMovies(movies);
  }

  Future<List<MovieListItem>> getFavorites() async {
    // get from cache
    final favorites = _movieMemoryDataSource.getFavorites();
    return sortMovies(favorites);
  }

  void toggleFavorite(int malId) {
    _movieMemoryDataSource.toggleFavorite(malId);
  }

  Future<MovieDetails> getDetails(int malId) async {
    return await _movieNetworkDataSource.getDetails(malId);
  }

  List<MovieListItem> sortMovies(List<MovieListItem> movies){
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

  void setSortOption(SortOptions newSortOption) {
    sortOption = newSortOption;
  }
}