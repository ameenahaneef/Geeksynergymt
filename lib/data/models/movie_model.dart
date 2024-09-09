class Movie {
  final String id;
  final String title;
  final String language;
  final String genre;
  final String? description;
  final String poster;
  final List<String> director;
  final List<String> writers;
  final List<String> stars;
  final List<Vote> voted;
  final int totalVoted;
  final int voting;

  Movie({
    required this.id,
    required this.title,
    required this.language,
    required this.genre,
    this.description,
    required this.poster,
    required this.director,
    required this.writers,
    required this.stars,
    required this.voted,
    required this.totalVoted,
    required this.voting,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'],
      language: json['language'],
      genre: json['genre'],
      description: json['description'],
      poster: json['poster'],
      director: List<String>.from(json['director']),
      writers: List<String>.from(json['writers']),
      stars: List<String>.from(json['stars']),
      voted: (json['voted'] as List<dynamic>).map((v) => Vote.fromJson(v)).toList(),
      totalVoted: json['totalVoted'],
      voting: json['voting'],
    );
  }
}

class Vote {
  final List<String> upVoted;
  final List<String> downVoted;
  final String id;
  final String genre;

  Vote({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.genre,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      upVoted: List<String>.from(json['upVoted']),
      downVoted: List<String>.from(json['downVoted']),
      id: json['_id'],
      genre: json['genre'],
    );
  }
}
