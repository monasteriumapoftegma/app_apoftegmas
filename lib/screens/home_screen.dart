import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/favoritos_service.dart';
import 'favoritos_screen.dart';
import '../models/apoftegma.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FavoritosService _favoritosService = FavoritosService();
  final Random _random = Random();
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _iniciarFilas();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', 
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  final List<Map<String, String>> _apoftegmas = [
    {
      'texto': 'Aprende a ter o coração em paz e milhares ao teu redor encontrarão a salvação.',
      'autor': 'Santo Antão do Egito',
    },
    {
      'texto': 'Guarda o teu coração com toda a atenção, pois dele brotam as fontes da vida.',
      'autor': 'São Basílio Magno',
    },
    {
      'texto': 'Se queres encontrar o repouso nesta vida e na outra, dize em toda a ocasião: Quem sou eu?',
      'autor': 'Pais do Deserto',
    },
    {
      'texto': 'A oração é o refúgio para todas as tempestades, a luz na escuridão e a força na fraqueza.',
      'autor': 'São João Crisóstomo',
    },
    {
      'texto': 'A paciência é o fruto do amor e a raiz de todas as virtudes.',
      'autor': 'São Pacómio',
    },
    {
      'texto': 'Não julgues o teu irmão e Deus não te julgará.',
      'autor': 'Abba Mateus',
    },
  ];

  final List<String> _backgrounds = [
    // Paisagens Naturais e Florestas Místicas
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1000',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=1000',
    'https://images.unsplash.com/photo-1426604966848-d7adac402bff?q=80&w=1000',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1000',
    'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=1000',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1000',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?q=80&w=1000',
    'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?q=80&w=1000',
    'https://images.unsplash.com/photo-1433086966358-54859d0ed716?q=80&w=1000',
    'https://images.unsplash.com/photo-1497436072909-60f360e1d4b1?q=80&w=1000',
    'https://images.unsplash.com/photo-1511497584788-876761142197?q=80&w=1000',
    'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?q=80&w=1000',
    'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=1000',
    'https://images.unsplash.com/photo-1542224566-6e85f2e6772f?q=80&w=1000',
    'https://images.unsplash.com/photo-1518495973542-4542c06a5843?q=80&w=1000',
    'https://images.unsplash.com/photo-1465146344425-f00d5f5c8f07?q=80&w=1000',
    'https://images.unsplash.com/photo-1473448912268-2022ce9509d8?q=80&w=1000',
    'https://images.unsplash.com/photo-1510784722466-f2aa9c52fff6?q=80&w=1000',
    'https://images.unsplash.com/photo-1448375240586-882707db888b?q=80&w=1000',
    'https://images.unsplash.com/photo-1502082553048-f009c37129b9?q=80&w=1000',

    // Montanhas, vales e desertos
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=80&w=1000',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=1000',
    'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?q=80&w=1000',
    'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?q=80&w=1000',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?q=80&w=1000',
    'https://images.unsplash.com/photo-1465188162913-8fb5749d6857?q=80&w=1000',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?q=80&w=1000',
    'https://images.unsplash.com/photo-1532274402911-5a369e4c4bb5?q=80&w=1000',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=1000',
    'https://images.unsplash.com/photo-1516026669329-813c9e472666?q=80&w=1000',

    // Arquitetura antiga e contemplativa
    'https://images.unsplash.com/photo-1548625149-fc4a29cf7092?q=80&w=1000',
    'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?q=80&w=1000',
    'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?q=80&w=1000',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1000',
    'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?q=80&w=1000',
    'https://images.unsplash.com/photo-1488646953014-85cb44e25828?q=80&w=1000',
    'https://images.unsplash.com/photo-1508873696983-2df5f920ac9c?q=80&w=1000',
    'https://images.unsplash.com/photo-1498550744921-75f79806b8a7?q=80&w=1000',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=1000',
    'https://images.unsplash.com/photo-1526772662000-3f88f10405ff?q=80&w=1000',

    // Céus e entardeceres
    'https://images.unsplash.com/photo-1534088568595-a066f410bcda?q=80&w=1000',
    'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?q=80&w=1000',
    'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=1000',
    'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?q=80&w=1000',
    'https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?q=80&w=1000',
    'https://images.unsplash.com/photo-1475483768296-6163e08872a1?q=80&w=1000',
    'https://images.unsplash.com/photo-1517760444937-f6397edcbbcd?q=80&w=1000',
    'https://images.unsplash.com/photo-1507499739999-097706ad8914?q=80&w=1000',
    'https://images.unsplash.com/photo-1445307806236-ff4e81544eb3?q=80&w=1000',
    'https://images.unsplash.com/photo-1519692933481-e162a57d6721?q=80&w=1000',
  ];

  List<Map<String, String>> _filaTextos = [];
  int _posTexto = 0;
  Map<String, String>? _atual;

  List<String> _filaFundos = [];
  int _posFundo = 0;
  String _fundoAtual = '';

  bool _isLiked = false;

  void _iniciarFilas() {
    _filaTextos = List<Map<String, String>>.of(_apoftegmas)..shuffle(_random);
    _filaFundos = List<String>.of(_backgrounds)..shuffle(_random);
    _posTexto = 0;
    _posFundo = 0;

    setState(() {
      _atual = _filaTextos[_posTexto++];
      _fundoAtual = _filaFundos[_posFundo++];
    });
    
    _verificarSeEhFavorito();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precarregarProximoFundo();
    });
  }

  void _precarregarProximoFundo() {
    if (!mounted || _filaFundos.isEmpty) return;
    int proxIndex = _posFundo % _filaFundos.length;
    precacheImage(NetworkImage(_filaFundos[proxIndex]), context)
        .catchError((_) {});
  }

  Future<void> _verificarSeEhFavorito() async {
    final item = _atual;
    if (item == null) return;
    final String id = item['texto']!;

    final status = await _favoritosService.isFavorito(id);
    if (!mounted) return;
    setState(() {
      _isLiked = status;
    });
  }

  Future<void> _alternarFavoritoAtual() async {
    final item = _atual;
    if (item == null) return;
    final String id = item['texto']!;

    await _favoritosService.alternarFavorito(id);
    await _verificarSeEhFavorito();
  }

  String get _textoCompleto {
    final item = _atual;
    if (item == null) return '';
    return '“${item['texto']}”\n— ${item['autor']}\n\nMonasterium';
  }

  void _novoApoftegma() {
    if (_filaTextos.isEmpty) return;

    if (_posTexto >= _filaTextos.length) {
      _filaTextos.shuffle(_random);
      _posTexto = 0;
    }

    if (_posFundo >= _filaFundos.length) {
      _filaFundos.shuffle(_random);
      _posFundo = 0;
    }

    setState(() {
      _atual = _filaTextos[_posTexto++];
      _fundoAtual = _filaFundos[_posFundo++];
    });

    _verificarSeEhFavorito();
    _precarregarProximoFundo();
  }

  Future<void> _copiarTexto() async {
    await Clipboard.setData(ClipboardData(text: _textoCompleto));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Apoftegma copiado!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _partilharTexto() async {
    try {
      await SharePlus.instance.share(ShareParams(text: _textoCompleto));
    } catch (_) {
      await _copiarTexto();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = _atual ?? _apoftegmas[0];

    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: CachedNetworkImage(
              key: ValueKey<String>(_fundoAtual),
              imageUrl: _fundoAtual,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => Container(color: Colors.black),
              errorWidget: (context, url, error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _novoApoftegma();
                });
                return Container(color: Colors.black);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'MONASTERIUM',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.redAccent),
                            tooltip: 'Ver Favoritos',
                            onPressed: () async {
                              final listaModelos = _apoftegmas.asMap().entries.map((e) {
                                return Apoftegma(
                                  id: e.key,
                                  texto: e.value['texto']!,
                                  autor: e.value['autor']!,
                                  categoria: 'Geral',
                                );
                              }).toList();

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoritosScreen(
                                    todosApoftegmas: listaModelos,
                                  ),
                                ),
                              );
                              _verificarSeEhFavorito();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline, color: Colors.white),
                            onPressed: () {
                              showAboutDialog(
                                context: context,
                                applicationName: 'Monasterium',
                                applicationVersion: '1.0.0',
                                applicationIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.church,
                                    size: 40,
                                    color: Colors.amber,
                                  ),
                                ),
                                applicationLegalese: '© 2026 Monasterium. Todos os direitos reservados.',
                                children: [
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Monasterium é uma biblioteca de espiritualidade, sabedoria e literatura dos Padres do Deserto.',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Política de Privacidade:',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Esta aplicação não recolhe, armazena nem partilha quaisquer dados pessoais dos utilizadores.',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['texto']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 1)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '- ${item['autor']} -',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.amberAccent,
                          shadows: [
                            Shadow(blurRadius: 8, color: Colors.black, offset: Offset(1, 1)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Curtir',
                              icon: Icon(
                                _isLiked ? Icons.favorite : Icons.favorite_border,
                                color: _isLiked ? Colors.redAccent : Colors.white,
                                size: 28,
                              ),
                              onPressed: _alternarFavoritoAtual,
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              tooltip: 'Copiar',
                              icon: const Icon(Icons.copy, color: Colors.white, size: 26),
                              onPressed: _copiarTexto,
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              tooltip: 'Compartilhar',
                              icon: const Icon(Icons.share, color: Colors.white, size: 26),
                              onPressed: _partilharTexto,
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white70, width: 1.5),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: _novoApoftegma,
                              icon: const Icon(Icons.refresh),
                              label: const Text(
                                'Novo Apoftegma',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _isBannerAdLoaded && _bannerAd != null
                          ? SizedBox(
                              width: _bannerAd!.size.width.toDouble(),
                              height: _bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd!),
                            )
                          : Container(
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white24, width: 0.5),
                              ),
                              child: const Text(
                                'A carregar anúncio...',
                                style: TextStyle(color: Colors.white54, fontSize: 12),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}