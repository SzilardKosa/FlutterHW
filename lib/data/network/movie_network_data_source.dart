import 'package:flutter_hf/data/network/movie_network_service.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';


class MovieNetworkDataSource {
  var _movieService = MovieService();

  Future<List<MovieListItem>> getMovies(String orderBy, String sort) async {
    var response = await _movieService.getMovieList(orderBy, sort);
    return response.results.map((m) => MovieListItem(
      m.malId,
      m.title,
      m.startDate,
      m.score,
      m.members,
      m.imageUrl,
      false
    )).toList();
  }

  Future<MovieDetails> getDetails(int malId) async {
    var response = await _movieService.getMovieDetails(malId);
    var details = MovieDetails(
        response.malId,
        response.title,
        response.imageUrl,
        response.score,
        response.members,
        response.aired.from,
        response.rating,
        response.synopsis,
        false,
    );
    return details;
  }
}