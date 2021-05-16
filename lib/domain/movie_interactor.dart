import 'package:flutter_hf/data/memory/movie_memory_data_source.dart';
import 'package:flutter_hf/data/network/movie_network_data_source.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';


class MovieInteractor {
  var _movieNetworkDataSource = MovieNetworkDataSource();
  var _movieMemoryDataSource = MovieMemoryDataSource();

  Future<List<MovieListItem>> getMovies() async {

    // get from cache
    List<MovieListItem> movies = _movieMemoryDataSource.getMovies();

    if(movies.isEmpty) {
      // get from network
      movies = await _movieNetworkDataSource.getMovies("start_date", "desc");
      // save to cache
      _movieMemoryDataSource.saveMovies(movies);
    }

    return movies;
  }

  Future<List<MovieListItem>> getFavorites() async {
    // get from cache
    return _movieMemoryDataSource.getFavorites();
  }

  void toggleFavorite(int malId) {
    _movieMemoryDataSource.toggleFavorite(malId);
  }


  Future<MovieDetails> getDetails(int malId) async {
    return await _movieNetworkDataSource.getDetails(malId);
  }
}