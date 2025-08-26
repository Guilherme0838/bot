import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // URL exemplo - substitua pela sua URL real do GitHub
  static const String dataUrl = 'https://raw.githubusercontent.com/usuario/acaiteria_database/main/produtos.json';
  
  // Dados de exemplo caso a URL do GitHub não esteja disponível
  static const String _dadosExemplo = '''
  [
    {
      "id": 1,
      "nome": "Açaí Tradicional",
      "descricao": "Açaí puro batido na hora, cremoso e saboroso",
      "preco": 12.50,
      "imagemUrl": "https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Açaí+Tradicional",
      "categoria": "Açaí",
      "ingredientes": ["Açaí", "Guaraná em pó"]
    },
    {
      "id": 2,
      "nome": "Açaí com Banana",
      "descricao": "Açaí cremoso com banana fresca e granola crocante",
      "preco": 15.00,
      "imagemUrl": "https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Açaí+com+Banana",
      "categoria": "Açaí",
      "ingredientes": ["Açaí", "Banana", "Granola", "Mel"]
    },
    {
      "id": 3,
      "nome": "Açaí Completo",
      "descricao": "Açaí com banana, morango, granola, leite condensado e chocolate",
      "preco": 18.50,
      "imagemUrl": "https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Açaí+Completo",
      "categoria": "Açaí",
      "ingredientes": ["Açaí", "Banana", "Morango", "Granola", "Leite condensado", "Chocolate granulado"]
    },
    {
      "id": 4,
      "nome": "Smoothie de Açaí",
      "descricao": "Bebida refrescante de açaí com frutas vermelhas",
      "preco": 10.00,
      "imagemUrl": "https://via.placeholder.com/300x200/E91E63/FFFFFF?text=Smoothie+Açaí",
      "categoria": "Bebida",
      "ingredientes": ["Açaí", "Morango", "Framboesa", "Água de coco"]
    },
    {
      "id": 5,
      "nome": "Taça Fitness",
      "descricao": "Açaí com frutas, granola sem açúcar e pasta de amendoim",
      "preco": 16.00,
      "imagemUrl": "https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Taça+Fitness",
      "categoria": "Açaí",
      "ingredientes": ["Açaí", "Banana", "Morango", "Granola sem açúcar", "Pasta de amendoim", "Chia"]
    }
  ]
  ''';

  static Future<List<Product>> buscarProdutos() async {
    try {
      // Tenta buscar da URL do GitHub primeiro
      final response = await http.get(Uri.parse(dataUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        // Se falhar, usa dados de exemplo
        return _usarDadosExemplo();
      }
    } catch (error) {
      // Em caso de erro de rede, usa dados de exemplo
      print('Erro ao buscar dados do GitHub, usando dados de exemplo: $error');
      return _usarDadosExemplo();
    }
  }

  static List<Product> _usarDadosExemplo() {
    try {
      final List<dynamic> jsonData = json.decode(_dadosExemplo);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } catch (error) {
      throw Exception("Erro ao processar dados de exemplo: $error");
    }
  }

  static Future<List<Product>> buscarProdutosPorCategoria(String categoria) async {
    final produtos = await buscarProdutos();
    return produtos.where((produto) => produto.categoria == categoria).toList();
  }

  static Future<Product?> buscarProdutoPorId(int id) async {
    final produtos = await buscarProdutos();
    try {
      return produtos.firstWhere((produto) => produto.id == id);
    } catch (e) {
      return null;
    }
  }
}
