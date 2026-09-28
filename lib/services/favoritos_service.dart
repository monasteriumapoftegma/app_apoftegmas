import 'package:shared_preferences/shared_preferences.dart';

class FavoritosService {
  static const String _keyFavoritos = 'favoritos_ids';

  /// Retorna a lista de IDs dos itens favoritados.
  Future<List<String>> obterFavoritosIds() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_keyFavoritos) ?? [];
  }

  /// Adiciona ou remove um ID dos favoritos.
  Future<void> alternarFavorito(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> favoritos =
        prefs.getStringList(_keyFavoritos) ?? [];

    if (favoritos.contains(id)) {
      favoritos.remove(id);
    } else {
      favoritos.add(id);
    }

    await prefs.setStringList(_keyFavoritos, favoritos);
  }

  /// Verifica se um determinado ID está favoritado.
  Future<bool> isFavorito(String id) async {
    final favoritos = await obterFavoritosIds();

    return favoritos.contains(id);
  }
}
