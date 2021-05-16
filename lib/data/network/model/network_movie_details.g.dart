// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkMovieDetails _$NetworkMovieDetailsFromJson(Map<String, dynamic> json) {
  return NetworkMovieDetails(
    json['mal_id'] as int,
    json['url'] as String,
    json['image_url'] as String,
    json['title'] as String,
    json['airing'] as bool,
    json['synopsis'] as String,
    json['type'] as String,
    json['episodes'] as int,
    (json['score'] as num).toDouble(),
    json['members'] as int,
    json['rating'] as String,
    NetworkMovieDetailsAired.fromJson(json['aired'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NetworkMovieDetailsToJson(
        NetworkMovieDetails instance) =>
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
      'members': instance.members,
      'rating': instance.rating,
      'aired': instance.aired,
    };

NetworkMovieDetailsAired _$NetworkMovieDetailsAiredFromJson(
    Map<String, dynamic> json) {
  return NetworkMovieDetailsAired(
    DateTime.parse(json['from'] as String),
  );
}

Map<String, dynamic> _$NetworkMovieDetailsAiredToJson(
        NetworkMovieDetailsAired instance) =>
    <String, dynamic>{
      'from': instance.from.toIso8601String(),
    };
