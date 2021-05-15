import 'package:flutter_hf/data/movie_network_data_source.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';


class MovieInteractor {
  var _movieNetworkDataSource = MovieNetworkDataSource();

  Future<List<MovieListItem>> getMovies(String orderBy, String sort) async {
    return await _movieNetworkDataSource.getMovies(orderBy, sort);
  }

  Future<MovieDetails> getDetails(int malId) async {
    return await _movieNetworkDataSource.getDetails(malId);
  }
}