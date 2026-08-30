class Game {
  final int id;
  final String name;
  final String? image;
  final double rating;
  final String? released;
  final List<String> genres;
  final List<String> platforms;

  Game({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.released,
    required this.genres,
    required this.platforms,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final genresJson = json['genres'] as List? ?? [];
    final platformsJson = json['platforms'] as List? ?? [];

    return Game(
      id: json['id'],
      name: json['name'] ?? 'Sin nombre',
      image: json['background_image'],
      rating: (json['rating'] ?? 0).toDouble(),
      released: json['released'],
      genres: genresJson.map((genre) => genre['name'].toString()).toList(),
      platforms: platformsJson
          .map((item) => item['platform']['name'].toString())
          .toList(),
    );
  }
}
