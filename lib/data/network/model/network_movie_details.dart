import 'package:flutter_hf/domain/model/movie_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_movie_details.g.dart';

@JsonSerializable()
class NetworkMovieDetails{
  @JsonKey(name: "mal_id") final int malId;
  final String url;
  @JsonKey(name: "image_url") final String imageUrl;
  final String title;
  final bool airing;
  final String synopsis;
  final String type;
  final int episodes;
  final double score;
  final int members;
  final String rating;
  final NetworkMovieDetailsAired aired;

  NetworkMovieDetails(
    this.malId,
    this.url,
    this.imageUrl,
    this.title,
    this.airing,
    this.synopsis,
    this.type,
    this.episodes,
    this.score,
    this.members,
    this.rating,
    this.aired
  );

  factory NetworkMovieDetails.fromJson(Map<String, dynamic> json) => _$NetworkMovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkMovieDetailsToJson(this);
}

@JsonSerializable()
class NetworkMovieDetailsAired{
  final DateTime from;

  NetworkMovieDetailsAired(this.from);

  factory NetworkMovieDetailsAired.fromJson(Map<String, dynamic> json) => _$NetworkMovieDetailsAiredFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkMovieDetailsAiredToJson(this);
}