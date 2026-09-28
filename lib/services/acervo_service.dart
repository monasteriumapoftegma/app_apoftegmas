import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/apoftegma.dart';

class AcervoService {
  Future<List<Apoftegma>> carregarAcervo() async {
    final String response = await rootBundle.loadString('json/apoftegmas.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Apoftegma.fromJson(json)).toList();
  }
}