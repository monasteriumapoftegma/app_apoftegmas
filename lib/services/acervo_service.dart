import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/apoftegma.dart';

class AcervoService {
  // Todo arquivo .json colocado nesta pasta é carregado automaticamente.
  static const String _pasta = 'assets/json/';

  List<Apoftegma>? _cache;

  Future<List<Apoftegma>> carregarAcervo() async {
    final guardado = _cache;
    if (guardado != null) return guardado;

    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final arquivos = manifest
        .listAssets()
        .where((caminho) => caminho.startsWith(_pasta) && caminho.endsWith('.json'))
        .toList()
      ..sort();

    final lista = <Apoftegma>[];
    final vistos = <String>{};

    for (final caminho in arquivos) {
      try {
        final String response = await rootBundle.loadString(caminho);
        final List<dynamic> data = json.decode(response) as List<dynamic>;

        for (final item in data) {
          final apoftegma = Apoftegma.fromJson(item as Map<String, dynamic>);
          final chave = apoftegma.texto.trim().toLowerCase();

          // Descarta textos vazios e textos repetidos.
          if (chave.isEmpty || !vistos.add(chave)) continue;
          lista.add(apoftegma);
        }
      } catch (e) {
        // Se um arquivo tiver erro, os outros continuam funcionando.
        debugPrint('Erro ao ler $caminho: $e');
      }
    }

    _cache = lista;
    return lista;
  }
}