import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_hf/data/model/network_movie_details.dart';
import 'package:flutter_hf/data/model/network_movie_list.dart';
import 'package:http/http.dart' as http;

const _baseUrl = "api.jikan.moe";

NetworkMovieList _parseMovieListResponse(String message){
  return NetworkMovieList.fromJson(jsonDecode(message));
}

NetworkMovieDetails _parseMovieDetailsResponse(String message){
  return NetworkMovieDetails.fromJson(jsonDecode(message));
}

class MovieService {
  Future<NetworkMovieList> getMovieList(String orderBy, String sort) async {
    log('starting network request');
    var response = await http.get(
      Uri.https(_baseUrl, "v3/search/anime", {
        "q": "",
        "type": "movie",
        "producer": "21",
        "order_by": orderBy,
        "sort": sort,
      }),
    );
    log(response.body.toString());
    return await compute(_parseMovieListResponse, response.body);
  }

  Future<NetworkMovieDetails> getMovieDetails(int malId) async {
    var response = await http.get(
      Uri.https(_baseUrl, "v3/anime/$malId"),
    );
    return await compute(_parseMovieDetailsResponse, response.body);
  }

}