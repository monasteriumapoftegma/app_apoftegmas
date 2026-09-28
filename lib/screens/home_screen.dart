import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/apoftegma.dart';
import '../services/acervo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final AcervoService _acervoService = AcervoService();
  Apoftegma? _apoftegmaAtual;
  bool _isLoading = true;
  String _imageUrl = '';
  int _localImageIndex = 0;

  static const String _emailApp = 'monasteriumapoftegma@gmail.com';

  final List _localImages = [
    'assets/images/paisagem_1.webp',
    'assets/images/paisagem_2.webp',
    'assets/images/paisagem_3.webp',
  ];

  @override
  void initState() {
    super.initState();
    _carregarApoftegmaAleatorio();
  }

  void _carregarApoftegmaAleatorio() async {
    setState(() => _isLoading = true);

    try {
      final acervo = await _acervoService.carregarAcervo();
      final random = Random();
      if (acervo.isNotEmpty) {
        _apoftegmaAtual = acervo[random.nextInt(acervo.length)];
      }
    } catch (_) {
      _apoftegmaAtual = Apoftegma(
        id: '1',
        texto: 'Aprende a ter o coração em paz e milhares ao teu redor encontrarão a salvação.',
        autor: 'Santo Antão do Egito',
        categoria: 'Geral',
      );
    }

    final random = Random();
    final randomSeed = random.nextInt(1000);
    final urlNuvem = 'https://picsum.photos/seed/$randomSeed/1080/1920';

    setState(() {
      _imageUrl = urlNuvem;
      _localImageIndex = random.nextInt(_localImages.length);
      _isLoading = false;
    });
  }

  void _exibirDialogoDoacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apoie o Monasterium'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sua doação ajuda a manter a aplicação ativa e sem publicidade invasiva.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chave PIX (E-mail):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: SelectableText(
                      _emailApp,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: _emailApp));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chave PIX copiada!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _exibirSobreOApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre o Monasterium'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Coletânea de sabedoria dos Pais do Deserto e Tradição Monástica.'),
            SizedBox(height: 12),
            Text(
              'Contato & Suporte:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(_emailApp),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (!_isLoading)
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  _localImages[_localImageIndex],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF4EFE6),
                  ),
                );
              },
            ),

          Container(
            color: Colors.black.withOpacity(0.55),
          ),

          SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'MONASTERIUM',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.favorite, color: Colors.redAccent),
                                  onPressed: () => _exibirDialogoDoacao(context),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.info_outline, color: Colors.white),
                                  onPressed: () => _exibirSobreOApp(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _apoftegmaAtual?.texto ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    height: 1.5,
                                    fontFamily: 'Serif',
                                    shadows: [
                                      Shadow(
                                        blurRadius: 6.0,
                                        color: Colors.black,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '- ${_apoftegmaAtual?.autor ?? "Tradição Monástica"} -',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.amberAccent,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white54),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: _carregarApoftegmaAleatorio,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Sortear Novo Ensinamento'),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}