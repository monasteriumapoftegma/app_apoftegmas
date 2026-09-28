import 'package:flutter/material.dart';

class ModaisDialogs {
  // Modal de Apoio / Doação
  static void exibirModalDoacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Apoie o Monasterium'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'O Monasterium é um projeto gratuito, sem anúncios e totalmente offline.\n\n'
                'Se este aplicativo auxilia sua vida de oração e estudos, considere fazer uma contribuição voluntária para cobrir custos de manutenção e novos conteúdos.',
              ),
              SizedBox(height: 16),
              SelectableText(
                'Chave Pix:\nsuporte@monasterium.app',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  // Modal LGPD / Termos de Uso
  static void exibirModalLGPD(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Privacidade e Termos'),
        content: const SingleChildScrollView(
          child: Text(
            'Respeito à sua Privacidade (LGPD):\n\n'
            '• O Monasterium opera 100% offline.\n'
            '• Não coletamos, armazenamos ou transmitimos seus dados pessoais, histórico de leitura ou favoritos para servidores externos.\n'
            '• Suas preferências e favoritos ficam salvos exclusivamente no armazenamento local do seu dispositivo.\n\n'
            'Conteúdo:\n'
            'O acervo consiste em textos de domínio público da Tradição Católica.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}