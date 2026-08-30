import '../models/game.dart';

class VaultService {
  // Lista compartida de videojuegos guardados.
  static final List<Game> _favoriteGames = [];

  // Devuelve los videojuegos guardados.
  static List<Game> get favorites => List.unmodifiable(_favoriteGames);

  // Comprueba si un videojuego está guardado.
  static bool isFavorite(int gameId) {
    return _favoriteGames.any((game) => game.id == gameId);
  }

  // Agrega un videojuego.
  static void addGame(Game game) {
    if (!isFavorite(game.id)) {
      _favoriteGames.add(game);
    }
  }

  // Elimina un videojuego.
  static void removeGame(int gameId) {
    _favoriteGames.removeWhere((game) => game.id == gameId);
  }

  static void clearFavorites() {
    _favoriteGames.clear();
  }
}
