class Movie {
  final int? id;
  final String title;
  final String director;
  final String actors;
  final String genre;
  final String plot;
  final String poster;
  final String imdbRating;

  Movie({
    this.id,
    required this.title,
    required this.director,
    required this.actors,
    required this.genre,
    required this.plot,
    required this.poster,
    required this.imdbRating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final images = json['Images'] as List?;
    final poster = (images != null && images.isNotEmpty)
        ? images.first as String
        : json['Poster'] as String? ?? '';
    return Movie(
      title: json['Title'] as String? ?? '',
      director: json['Director'] as String? ?? '',
      actors: json['Actors'] as String? ?? '',
      genre: json['Genre'] as String? ?? '',
      plot: json['Plot'] as String? ?? '',
      poster: poster,
      imdbRating: json['imdbRating'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Director': director,
        'Actors': actors,
        'Genre': genre,
        'Plot': plot,
        'Poster': poster,
        'imdbRating': imdbRating,
      };

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'director': director,
        'actors': actors,
        'genre': genre,
        'plot': plot,
        'poster': poster,
        'imdbRating': imdbRating,
      };

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      director: map['director'] as String? ?? '',
      actors: map['actors'] as String? ?? '',
      genre: map['genre'] as String? ?? '',
      plot: map['plot'] as String? ?? '',
      poster: map['poster'] as String? ?? '',
      imdbRating: map['imdbRating'] as String? ?? '',
    );
  }
}
