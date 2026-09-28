import 'package:flutter/material.dart';

import '../models/apoftegma.dart';
import '../services/favoritos_service.dart';

class ApoftegmaDetalheScreen extends StatefulWidget {
  final Apoftegma apoftegma;

  const ApoftegmaDetalheScreen({
    super.key,
    required this.apoftegma,
  });

  @override
  State<ApoftegmaDetalheScreen> createState() =>
      _ApoftegmaDetalheScreenState();
}

class _ApoftegmaDetalheScreenState
    extends State<ApoftegmaDetalheScreen> {
  final FavoritosService _favoritosService = FavoritosService();

  bool _isFavorito = false;
  bool _isAlterandoFavorito = false;

  @override
  void initState() {
    super.initState();
    _verificarFavorito();
  }

  Future<void> _verificarFavorito() async {
    final status = await _favoritosService.isFavorito(widget.apoftegma.id.toString(),
    );

    if (!mounted) return;

    setState(() {
      _isFavorito = status;
    });
  }

  Future<void> _alternarFavorito() async {
    if (_isAlterandoFavorito) return;

    setState(() {
      _isAlterandoFavorito = true;
    });

    try {
      await _favoritosService.alternarFavorito(widget.apoftegma.id.toString(),
      );

      await _verificarFavorito();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isFavorito
                ? 'Adicionado aos favoritos'
                : 'Removido dos favoritos',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAlterandoFavorito = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apoftegma.autor),
        actions: [
          IconButton(
            icon: _isAlterandoFavorito
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    _isFavorito
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: _isFavorito ? Colors.red : null,
                  ),
            tooltip: _isFavorito
                ? 'Remover dos favoritos'
                : 'Adicionar aos favoritos',
            onPressed:
                _isAlterandoFavorito ? null : _alternarFavorito,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.apoftegma.texto,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Chip(
              label: Text(widget.apoftegma.categoria),
            ),
          ],
        ),
      ),
    );
  }
}
