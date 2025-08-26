# Açaiteria App 🍇

Um aplicativo Flutter moderno para açaiteria com integração de banco de dados via GitHub.

## 📱 Funcionalidades

- **Cardápio Digital**: Visualização de produtos de açaí com imagens, descrições e preços
- **Detalhes do Produto**: Informações completas incluindo ingredientes e opções de personalização
- **Sistema de Pedidos**: Carrinho de compras com controle de quantidade e observações
- **Dados do Cliente**: Formulário para informações de contato e entrega
- **Tipos de Entrega**: Opções de retirada no local ou entrega a domicílio
- **Interface Moderna**: Design limpo e responsivo em português brasileiro

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework principal para desenvolvimento mobile
- **Dart**: Linguagem de programação
- **HTTP**: Para requisições à API/GitHub
- **Material Design**: Para componentes de interface

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/
│   └── product.dart         # Modelo de dados do produto
├── services/
│   └── api_service.dart     # Serviço para buscar dados do GitHub
└── screens/
    ├── home_screen.dart     # Tela principal com lista de produtos
    ├── product_detail_screen.dart  # Detalhes do produto
    └── order_screen.dart    # Tela de pedidos
```

## 🚀 Como Executar

1. **Pré-requisitos**:
   - Flutter SDK instalado
   - Editor de código (VS Code, Android Studio)
   - Emulador ou dispositivo físico

2. **Instalação**:
   ```bash
   # Clone o repositório
   git clone [url-do-repositorio]
   
   # Entre no diretório
   cd acaiteria_app
   
   # Instale as dependências
   flutter pub get
   
   # Execute o app
   flutter run
   ```

## 📊 Banco de Dados (GitHub)

O app utiliza uma tabela hospedada no GitHub como fonte de dados. O formato esperado é um arquivo JSON com a seguinte estrutura:

```json
[
  {
    "id": 1,
    "nome": "Açaí Tradicional",
    "descricao": "Açaí puro batido na hora, cremoso e saboroso",
    "preco": 12.50,
    "imagemUrl": "https://exemplo.com/imagem.jpg",
    "categoria": "Açaí",
    "ingredientes": ["Açaí", "Guaraná em pó"]
  }
]
```

### Configuração da URL do GitHub

No arquivo `lib/services/api_service.dart`, atualize a constante `dataUrl` com a URL do seu arquivo JSON:

```dart
static const String dataUrl = 'https://raw.githubusercontent.com/seu-usuario/seu-repositorio/main/produtos.json';
```

## 🎨 Design e UX

- **Cores Principais**: Roxo profundo (#673AB7) e Rosa accent (#E91E63)
- **Tipografia**: Material Design com hierarquia clara
- **Layout**: Cards modernos com bordas arredondadas
- **Responsividade**: Adaptável a diferentes tamanhos de tela
- **Acessibilidade**: Contraste adequado e navegação intuitiva

## 📱 Telas do App

### 1. Tela Principal (Home)
- Lista de produtos em cards
- Filtros por categoria
- Busca e navegação

### 2. Detalhes do Produto
- Imagem em destaque
- Informações completas
- Seletor de quantidade
- Campo para observações
- Botão de adicionar ao pedido

### 3. Tela de Pedidos
- Lista de itens selecionados
- Formulário do cliente
- Opções de entrega
- Resumo financeiro
- Finalização do pedido

## 🔧 Funcionalidades Técnicas

- **Tratamento de Erros**: Fallback para dados locais em caso de falha na rede
- **Loading States**: Indicadores de carregamento durante requisições
- **Validação**: Formulários com validação de campos obrigatórios
- **Estado Local**: Gerenciamento de estado com StatefulWidget
- **Navegação**: Sistema de rotas nomeadas

## 📈 Possíveis Melhorias Futuras

- [ ] Integração com sistema de pagamento
- [ ] Notificações push para status do pedido
- [ ] Sistema de avaliações e comentários
- [ ] Programa de fidelidade
- [ ] Integração com mapas para entrega
- [ ] Modo offline com sincronização
- [ ] Dashboard administrativo
- [ ] Relatórios de vendas

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Contato

Para dúvidas ou sugestões sobre o projeto, entre em contato através dos issues do GitHub.

---

**Desenvolvido com ❤️ para açaiterias brasileiras**
