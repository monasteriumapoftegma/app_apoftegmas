import 'package:flutter/material.dart';

import '../models/apoftegma.dart';
import '../services/favoritos_service.dart';

class FavoritosScreen extends StatefulWidget {
  final List<Apoftegma> todosApoftegmas;

  const FavoritosScreen({
    super.key,
    required this.todosApoftegmas,
  });

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  final FavoritosService _favoritosService = FavoritosService();

  List<String> _favoritosIds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }

  Future<void> _carregarFavoritos() async {
    final ids = await _favoritosService.obterFavoritosIds();

    if (!mounted) return;

    setState(() {
      _favoritosIds = ids;
      _isLoading = false;
    });
  }

  Future<void> _alternarFavorito(int id) async {
    await _favoritosService.alternarFavorito(id.toString());

    await _carregarFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final favoritos = widget.todosApoftegmas
        .where((item) => _favoritosIds.contains(item.id.toString()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favoritos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum favorito salvo ainda.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final item = favoritos[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.autor,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.texto,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Text(item.categoria),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              tooltip: 'Remover dos favoritos',
                              onPressed: () {
                                _alternarFavorito(item.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
