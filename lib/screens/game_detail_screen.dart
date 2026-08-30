import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/vault_service.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  late bool _isFavorite;
  @override
  void initState() {
    super.initState();

    _isFavorite = VaultService.isFavorite(widget.game.id);
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F26),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle del juego',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            SizedBox(
              width: double.infinity,
              height: 270,
              child: game.image != null
                  ? Image.network(
                      game.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imagePlaceholder();
                      },
                    )
                  : _imagePlaceholder(),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),
                  // Rating
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${game.rating.toStringAsFixed(1)} / 5',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Información',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  _infoRow(
                    Icons.calendar_month_outlined,
                    'Fecha de lanzamiento',
                    game.released ?? 'No disponible',
                  ),

                  const SizedBox(height: 14),

                  _infoRow(
                    Icons.category_outlined,
                    'Géneros',
                    game.genres.isNotEmpty
                        ? game.genres.join(' · ')
                        : 'No disponible',
                  ),

                  const SizedBox(height: 14),

                  _infoRow(
                    Icons.devices_outlined,
                    'Plataformas',
                    game.platforms.isNotEmpty
                        ? game.platforms.join(' · ')
                        : 'No disponible',
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Acerca de este juego',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Descubre ${game.name} y agrégalo a tu colección personal de GameVault.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey.shade300,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;

                          if (_isFavorite) {
                            VaultService.addGame(widget.game);
                          } else {
                            VaultService.removeGame(widget.game.id);
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isFavorite
                                  ? '${widget.game.name} fue agregado a Mi Vault'
                                  : '${widget.game.name} fue eliminado de Mi Vault',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        _isFavorite
                            ? 'Guardado en Mi Vault'
                            : 'Agregar a Mi Vault',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      alignment: Alignment.center,
      child: const Icon(Icons.sports_esports, size: 70),
    );
  }
}
