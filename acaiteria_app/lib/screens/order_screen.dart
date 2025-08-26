import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Simulação de itens no pedido
  List<Map<String, dynamic>> _itensPedido = [
    {
      'nome': 'Açaí Tradicional',
      'preco': 12.50,
      'quantidade': 2,
      'observacoes': ['Sem açúcar'],
    },
    {
      'nome': 'Açaí Completo',
      'preco': 18.50,
      'quantidade': 1,
      'observacoes': ['Mais granola', 'Pouco leite condensado'],
    },
  ];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  
  String _tipoEntrega = 'Retirada';
  
  double get _subtotal {
    return _itensPedido.fold(0.0, (total, item) {
      return total + (item['preco'] * item['quantidade']);
    });
  }

  double get _taxaEntrega {
    return _tipoEntrega == 'Entrega' ? 5.00 : 0.00;
  }

  double get _total {
    return _subtotal + _taxaEntrega;
  }

  void _removerItem(int index) {
    setState(() {
      _itensPedido.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removido do pedido'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _alterarQuantidade(int index, int novaQuantidade) {
    if (novaQuantidade > 0) {
      setState(() {
        _itensPedido[index]['quantidade'] = novaQuantidade;
      });
    }
  }

  void _finalizarPedido() {
    if (_itensPedido.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione itens ao pedido primeiro'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_nomeController.text.trim().isEmpty || _telefoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha nome e telefone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_tipoEntrega == 'Entrega' && _enderecoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o endereço para entrega'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simula finalização do pedido
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pedido Confirmado!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${_nomeController.text}'),
            Text('Telefone: ${_telefoneController.text}'),
            Text('Tipo: $_tipoEntrega'),
            if (_tipoEntrega == 'Entrega')
              Text('Endereço: ${_enderecoController.text}'),
            const SizedBox(height: 16),
            Text('Total: R\$ ${_total.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            const Text(
              'Tempo estimado: 30-45 minutos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Volta para a tela inicial
              setState(() {
                _itensPedido.clear();
                _nomeController.clear();
                _telefoneController.clear();
                _enderecoController.clear();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Pedido'),
        elevation: 0,
      ),
      body: _itensPedido.isEmpty
          ? _buildPedidoVazio()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lista de itens
                        _buildItensPedido(),
                        const SizedBox(height: 24),
                        
                        // Dados do cliente
                        _buildDadosCliente(),
                        const SizedBox(height: 24),
                        
                        // Tipo de entrega
                        _buildTipoEntrega(),
                        const SizedBox(height: 24),
                        
                        // Resumo do pedido
                        _buildResumoPedido(),
                      ],
                    ),
                  ),
                ),
                // Botão finalizar
                _buildBotaoFinalizar(),
              ],
            ),
    );
  }

  Widget _buildPedidoVazio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Seu pedido está vazio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Adicione alguns produtos deliciosos!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ver Cardápio'),
          ),
        ],
      ),
    );
  }

  Widget _buildItensPedido() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Itens do Pedido',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _itensPedido.length,
          itemBuilder: (context, index) {
            final item = _itensPedido[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['nome'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _removerItem(index),
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                        ),
                      ],
                    ),
                    if (item['observacoes'].isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        children: item['observacoes'].map<Widget>((obs) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              obs,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[700],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: item['quantidade'] > 1
                                  ? () => _alterarQuantidade(index, item['quantidade'] - 1)
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.deepPurple,
                            ),
                            Text(
                              item['quantidade'].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _alterarQuantidade(index, item['quantidade'] + 1),
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),
                        Text(
                          'R\$ ${(item['preco'] * item['quantidade']).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDadosCliente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dados do Cliente',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _nomeController,
          decoration: const InputDecoration(
            labelText: 'Nome completo *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _telefoneController,
          decoration: const InputDecoration(
            labelText: 'Telefone *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildTipoEntrega() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de Entrega',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Retirada'),
                subtitle: const Text('Grátis'),
                value: 'Retirada',
                groupValue: _tipoEntrega,
                onChanged: (value) {
                  setState(() {
                    _tipoEntrega = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Entrega'),
                subtitle: const Text('R\$ 5,00'),
                value: 'Entrega',
                groupValue: _tipoEntrega,
                onChanged: (value) {
                  setState(() {
                    _tipoEntrega = value!;
                  });
                },
              ),
            ),
          ],
        ),
        if (_tipoEntrega == 'Entrega') ...[
          const SizedBox(height: 12),
          TextField(
            controller: _enderecoController,
            decoration: const InputDecoration(
              labelText: 'Endereço completo *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            maxLines: 2,
          ),
        ],
      ],
    );
  }

  Widget _buildResumoPedido() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumo do Pedido',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:'),
              Text('R\$ ${_subtotal.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Taxa de entrega:'),
              Text('R\$ ${_taxaEntrega.toStringAsFixed(2)}'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$ ${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBotaoFinalizar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _finalizarPedido,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            'Finalizar Pedido - R\$ ${_total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }
}
