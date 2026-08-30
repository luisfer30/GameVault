import 'package:flutter/material.dart';
import 'services/rawg_service.dart';


void main() {
  runApp(const GameVaultApp());
}

class GameVaultApp extends StatelessWidget {
  const GameVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TestApiScreen(),
    );
  }
}

class TestApiScreen extends StatefulWidget {
  const TestApiScreen({super.key});

  @override
  State<TestApiScreen> createState() => _TestApiScreenState();
}

class _TestApiScreenState extends State<TestApiScreen> {
  final RawgService service = RawgService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameVault'),
      ),
      body: FutureBuilder(
        future: service.getGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final games = snapshot.data ?? [];

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];

              return ListTile(
                leading: game.image != null
                    ? Image.network(
                        game.image!,
                        width: 70,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.videogame_asset),
                title: Text(game.name),
                subtitle:
                    Text('Rating: ${game.rating}'),
              );
            },
          );
        },
      ),
    );
  }
}