// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_movie_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkMovieList _$NetworkMovieListFromJson(Map<String, dynamic> json) {
  return NetworkMovieList(
    json['request_hash'] as String,
    json['request_cached'] as bool,
    json['request_cache_expiry'] as int,
    json['last_page'] as int,
    (json['results'] as List<dynamic>)
        .map((e) => NetworkMovieListItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NetworkMovieListToJson(NetworkMovieList instance) =>
    <String, dynamic>{
      'request_hash': instance.requestHash,
      'request_cached': instance.requestCached,
      'request_cache_expiry': instance.requestCacheExpiry,
      'last_page': instance.lastPage,
      'results': instance.results,
    };

NetworkMovieListItem _$NetworkMovieListItemFromJson(Map<String, dynamic> json) {
  return NetworkMovieListItem(
    json['mal_id'] as int,
    json['url'] as String,
    json['image_url'] as String,
    json['title'] as String,
    json['airing'] as bool,
    json['synopsis'] as String,
    json['type'] as String,
    json['episodes'] as int,
    (json['score'] as num).toDouble(),
    DateTime.parse(json['start_date'] as String),
    DateTime.parse(json['end_date'] as String),
    json['members'] as int,
    json['rated'] as String,
  );
}

Map<String, dynamic> _$NetworkMovieListItemToJson(
        NetworkMovieListItem instance) =>
    <String, dynamic>{
      'mal_id': instance.malId,
      'url': instance.url,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'airing': instance.airing,
      'synopsis': instance.synopsis,
      'type': instance.type,
      'episodes': instance.episodes,
      'score': instance.score,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'members': instance.members,
      'rated': instance.rated,
    };
