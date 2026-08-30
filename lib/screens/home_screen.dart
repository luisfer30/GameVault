import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/rawg_service.dart';
import 'catalog_screen.dart';
import 'game_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RawgService _rawgService = RawgService();

  late Future<List<Game>> _gamesFuture;

  @override
  void initState() {
    super.initState();

    // Carga los videojuegos cuando inicia la pantalla.
    _gamesFuture = _rawgService.getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_esports, size: 28),
            SizedBox(width: 10),
            Text('GameVault', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Mi Vault',
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
        ],
      ),

      body: SafeArea(
        child: FutureBuilder<List<Game>>(
          future: _gamesFuture,
          builder: (context, snapshot) {
            // Mientras RAWG responde.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Si ocurre un error.
            if (snapshot.hasError) {
              return _buildError();
            }

            final games = snapshot.data ?? [];

            if (games.isEmpty) {
              return const Center(
                child: Text('No se encontraron videojuegos.'),
              );
            }

            return RefreshIndicator(
              onRefresh: _refreshGames,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                children: [
                  // Presentación
                  const Text(
                    'Descubre tu próximo juego',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Explora videojuegos y guarda tus favoritos en tu Vault.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade400,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Encabezado de destacados
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Destacados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CatalogScreen(),
                            ),
                          );
                        },
                        child: const Text('Ver todos'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Juegos destacados
                  SizedBox(
                    height: 260,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: games.length > 5 ? 5 : games.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        return _buildGameCard(games[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Populares',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 14),

                  // Lista de videojuegos
                  ...games.skip(5).map((game) => _buildGameListTile(game)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Tarjeta horizontal para videojuegos destacados.
  Widget _buildGameCard(Game game) {
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameDetailScreen(game: game),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
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
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.star, size: 17),
                        const SizedBox(width: 5),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: TextStyle(color: Colors.grey.shade300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Elementos de la sección de populares.
  Widget _buildGameListTile(Game game) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
                    errorBuilder: (context, error, stackTrace) {
                      return _imagePlaceholder();
                    },
                  )
                : _imagePlaceholder(),
          ),
        ),

        title: Text(
          game.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              const Icon(Icons.star, size: 16),
              const SizedBox(width: 4),
              Text(game.rating.toStringAsFixed(1)),
            ],
          ),
        ),

        trailing: const Icon(Icons.chevron_right),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailScreen(game: game),
            ),
          );
        },
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      alignment: Alignment.center,
      child: const Icon(Icons.sports_esports, size: 42),
    );
  }

  // Permite actualizar los juegos deslizando hacia abajo.
  Future<void> _refreshGames() async {
    setState(() {
      _gamesFuture = _rawgService.getGames();
    });

    await _gamesFuture;
  }

  // Pantalla mostrada cuando falla la API.
  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 60),

            const SizedBox(height: 16),

            const Text(
              'No pudimos cargar los videojuegos',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Comprueba tu conexión e inténtalo nuevamente.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _gamesFuture = _rawgService.getGames();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
