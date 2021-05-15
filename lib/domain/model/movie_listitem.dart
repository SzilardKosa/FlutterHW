
class MovieListItem{
  final int malId;
  final String title;
  final DateTime aired;
  final double score;
  final int members;
  final String imageUrl;
  final bool isFavorite;

  MovieListItem(
    this.malId,
    this.title,
    this.aired,
    this.score,
    this.members,
    this.imageUrl,
    this.isFavorite
  );
}

