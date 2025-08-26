class Product {
  final int id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  final String categoria;
  final List<String> ingredientes;

  Product({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
    required this.ingredientes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as int,
        nome: json['nome'] as String,
        descricao: json['descricao'] as String,
        preco: (json['preco'] as num).toDouble(),
        imagemUrl: json['imagemUrl'] as String? ?? '',
        categoria: json['categoria'] as String? ?? 'Açaí',
        ingredientes: List<String>.from(json['ingredientes'] as List? ?? []),
      );
    } catch (error) {
      throw Exception("Erro ao processar dados do produto: $error");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagemUrl': imagemUrl,
      'categoria': categoria,
      'ingredientes': ingredientes,
    };
  }
}
