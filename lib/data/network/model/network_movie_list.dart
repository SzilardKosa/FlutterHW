import 'package:json_annotation/json_annotation.dart';

part 'network_movie_list.g.dart';

@JsonSerializable()
class NetworkMovieList{
  @JsonKey(name: "request_hash") final String requestHash;
  @JsonKey(name: "request_cached") final bool requestCached;
  @JsonKey(name: "request_cache_expiry") final int requestCacheExpiry;
  @JsonKey(name: "last_page") final int lastPage;
  final List<NetworkMovieListItem> results;

  NetworkMovieList(
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.lastPage,
    this.results
  );

  factory NetworkMovieList.fromJson(Map<String, dynamic> json) => _$NetworkMovieListFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkMovieListToJson(this);
}

@JsonSerializable()
class NetworkMovieListItem {
  @JsonKey(name: "mal_id") final int malId;
  final String url;
  @JsonKey(name: "image_url") final String imageUrl;
  final String title;
  final bool airing;
  final String synopsis;
  final String type;
  final int episodes;
  final double score;
  @JsonKey(name: "start_date") final DateTime startDate;
  @JsonKey(name: "end_date") final DateTime endDate;
  final int members;
  final String rated;

  NetworkMovieListItem(
    this.malId,
    this.url,
    this.imageUrl,
    this.title,
    this.airing,
    this.synopsis,
    this.type,
    this.episodes,
    this.score,
    this.startDate,
    this.endDate,
    this.members,
    this.rated
  );

  factory NetworkMovieListItem.fromJson(Map<String, dynamic> json) => _$NetworkMovieListItemFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkMovieListItemToJson(this);
}