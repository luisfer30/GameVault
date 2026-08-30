class Game {
  final int id;
  final String name;
  final String? image;
  final double rating;

  Game({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'] ?? 'Sin nombre',
      image: json['background_image'],
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}