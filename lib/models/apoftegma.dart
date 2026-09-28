class Apoftegma {
  final dynamic id;
  final String autor;
  final String texto;
  final String categoria;

  Apoftegma({
    required this.id,
    required this.autor,
    required this.texto,
    required this.categoria,
  });

  factory Apoftegma.fromJson(Map<String, dynamic> json) {
    return Apoftegma(
      id: json['id'] ?? 0,
      autor: json['autor'] ?? 'Padre do Deserto',
      texto: json['texto'] ?? '',
      categoria: json['categoria'] ?? 'Apoftegmas',
    );
  }
}