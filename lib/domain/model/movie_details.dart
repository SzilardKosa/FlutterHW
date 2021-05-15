
class MovieDetails{
  final int malId;
  final String title;
  final String imageUrl;
  final double score;
  final int members;
  final DateTime aired;
  final String rated;
  final String synopsis;
  final bool isFavorite;

  MovieDetails(
    this.malId,
    this.title,
    this.imageUrl,
    this.score,
    this.members,
    this.aired,
    this.rated,
    this.synopsis,
    this.isFavorite,
  );
}

