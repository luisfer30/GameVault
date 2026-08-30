import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/vault_service.dart';
import 'game_detail_screen.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  @override
  Widget build(BuildContext context) {
    final games = VaultService.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Vault',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: games.isEmpty
          ? _buildEmptyVault()
          : _buildGameList(games),
    );
  }

  Widget _buildEmptyVault() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_border,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tu Vault está vacío',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Explora videojuegos y guarda tus favoritos para encontrarlos aquí.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.explore),
              label: const Text('Explorar juegos'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameList(List<Game> games) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: games.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final game = games[index];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),

            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 70,
                height: 70,
                child: game.image != null
                    ? Image.network(
                        game.image!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.sports_esports,
                        size: 40,
                      ),
              ),
            ),

            title: Text(
              game.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  game.rating.toStringAsFixed(1),
                ),
              ],
            ),

            trailing: IconButton(
              tooltip: 'Eliminar de Mi Vault',
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {
                _removeGame(game);
              },
            ),

            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GameDetailScreen(game: game),
                ),
              );

              // Refresca la pantalla si el usuario cambia
              // el favorito desde el detalle.
              setState(() {});
            },
          ),
        );
      },
    );
  }

  void _removeGame(Game game) {
    setState(() {
      VaultService.removeGame(game.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${game.name} fue eliminado de Mi Vault',
        ),
      ),
    );
  }
}