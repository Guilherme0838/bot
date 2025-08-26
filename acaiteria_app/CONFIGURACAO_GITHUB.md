# Configuração do Banco de Dados no GitHub 📊

Este documento explica como configurar uma tabela no GitHub para servir como banco de dados para o app da açaiteria.

## 🚀 Passo a Passo

### 1. Criar Repositório no GitHub

1. Acesse [GitHub.com](https://github.com) e faça login
2. Clique em "New repository" (Novo repositório)
3. Nomeie o repositório (ex: `acaiteria-database`)
4. Marque como **Public** (público)
5. Adicione um README.md
6. Clique em "Create repository"

### 2. Adicionar Arquivo JSON com os Produtos

1. No seu repositório, clique em "Add file" > "Create new file"
2. Nomeie o arquivo como `produtos.json`
3. Copie o conteúdo do arquivo `produtos_exemplo.json` deste projeto
4. Cole no editor do GitHub
5. Faça o commit com a mensagem "Adicionar produtos da açaiteria"

### 3. Obter URL Raw do Arquivo

1. Clique no arquivo `produtos.json` no seu repositório
2. Clique no botão "Raw" (no canto superior direito)
3. Copie a URL da barra de endereços
4. A URL deve ter o formato:
   ```
   https://raw.githubusercontent.com/SEU_USUARIO/acaiteria-database/main/produtos.json
   ```

### 4. Configurar no App Flutter

1. Abra o arquivo `lib/services/api_service.dart`
2. Localize a linha com `static const String dataUrl`
3. Substitua pela sua URL:
   ```dart
   static const String dataUrl = 'https://raw.githubusercontent.com/SEU_USUARIO/acaiteria-database/main/produtos.json';
   ```

## 📝 Estrutura do JSON

O arquivo JSON deve seguir esta estrutura:

```json
[
  {
    "id": 1,
    "nome": "Nome do Produto",
    "descricao": "Descrição detalhada do produto",
    "preco": 15.50,
    "imagemUrl": "https://exemplo.com/imagem.jpg",
    "categoria": "Açaí",
    "ingredientes": ["Ingrediente 1", "Ingrediente 2"]
  }
]
```

### Campos Obrigatórios:
- `id`: Número único do produto
- `nome`: Nome do produto
- `descricao`: Descrição do produto
- `preco`: Preço em formato decimal
- `imagemUrl`: URL da imagem (pode usar placeholder)
- `categoria`: Categoria do produto
- `ingredientes`: Array com lista de ingredientes

## 🖼️ Imagens dos Produtos

### Opção 1: Placeholder (Recomendado para testes)
Use URLs de placeholder como:
```
https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Nome+do+Produto
```

### Opção 2: Imagens Reais
1. Faça upload das imagens para o mesmo repositório GitHub
2. Use URLs no formato:
   ```
   https://raw.githubusercontent.com/SEU_USUARIO/acaiteria-database/main/imagens/produto1.jpg
   ```

### Opção 3: Serviços de Hospedagem
- Imgur
- Cloudinary
- AWS S3
- Google Drive (com link público)

## 🔄 Atualizando os Dados

Para atualizar o cardápio:

1. Acesse seu repositório no GitHub
2. Clique no arquivo `produtos.json`
3. Clique no ícone de edição (lápis)
4. Faça as alterações necessárias
5. Commit as mudanças
6. O app será atualizado automaticamente na próxima requisição

## 📱 Testando a Integração

1. Execute o app Flutter
2. Verifique se os produtos aparecem na tela inicial
3. Se houver erro, o app usará dados de exemplo
4. Verifique o console para mensagens de erro

## 🛠️ Solução de Problemas

### Produtos não aparecem:
- Verifique se a URL está correta
- Confirme se o repositório é público
- Teste a URL no navegador
- Verifique a estrutura do JSON

### Imagens não carregam:
- Confirme se as URLs das imagens estão corretas
- Teste as URLs das imagens no navegador
- Use placeholders temporariamente

### Erro de CORS (apenas web):
- GitHub Raw não tem problemas de CORS
- Se usar outro serviço, configure CORS adequadamente

## 📊 Exemplo de Repositório

Você pode ver um exemplo funcional em:
```
https://github.com/exemplo/acaiteria-database
```

## 🔐 Segurança

- Mantenha o repositório público para acesso via Raw URL
- Não inclua informações sensíveis no JSON
- Para dados privados, considere usar APIs com autenticação

## 📈 Expansões Futuras

- Adicionar campo `disponivel` (boolean)
- Incluir `promocao` com preço especial
- Adicionar `tempo_preparo` em minutos
- Incluir `calorias` e informações nutricionais
- Adicionar `tags` para filtros avançados

---

**Dica**: Mantenha backups regulares do seu arquivo JSON e considere usar branches para testar mudanças antes de aplicar na branch principal.
