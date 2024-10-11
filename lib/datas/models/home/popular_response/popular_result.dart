import 'dart:convert';

class PopularResult {
  bool? adult;
  String? backdropPath;
  List<dynamic>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  PopularResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory PopularResult.fromMap(Map<String, dynamic> data) => PopularResult(
        adult: data['adult'] as bool?,
        backdropPath: data['backdrop_path'] as String?,
        genreIds: data['genre_ids'] as List<dynamic>?,
        id: data['id'] as int?,
        originalLanguage: data['original_language'] as String?,
        originalTitle: data['original_title'] as String?,
        popularity: (data['popularity'] as num?)?.toDouble(),
        posterPath: data['poster_path'] as String?,
        releaseDate: data['release_date'] as String?,
        title: data['title'] as String?,
        video: data['video'] as bool?,
        voteAverage: (data['vote_average'] as num?)?.toDouble(),
        voteCount: data['vote_count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genre_ids': genreIds,
        'id': id,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PopularResult].
  factory PopularResult.fromJson(String data) {
    return PopularResult.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PopularResult] to a JSON string.
  String toJson() => json.encode(toMap());
}
