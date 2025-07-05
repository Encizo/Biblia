# 📖 Bíblia com Estudo IA

Aplicativo Flutter que permite ao usuário navegar pelos livros da Bíblia, selecionar versículos e gerar estudos avançados com base em inteligência artificial (OpenAI API). Os estudos são salvos em tempo real no Firebase Firestore, com autenticação de usuários via Firebase Authentication.

## 🔧 Tecnologias Utilizadas

- Flutter
- Firebase Authentication
- Firebase Firestore
- FlutterFire CLI
- OpenAI API
- .env (variáveis de ambiente)
- Abíblia Digital API (https://www.abibliadigital.com.br)

---

## 🚀 Funcionalidades

- 📚 Navegação por livros e capítulos da Bíblia
- ✍️ Geração de estudo personalizado com IA por versículo
- 🔐 Registro e login com Firebase Authentication
- 📂 Salvamento dos estudos por usuário no Firestore
- 🔎 Busca por livros
- 🌙 Interface escura minimalista

---

## ⚙️ Configuração do Projeto

### 1. Clone o repositório

git clone https://github.com/seu-usuario/biblia-estudos-app.git
cd biblia-estudos-app
### 2. Instale as dependências
bash
Copiar
Editar
flutter pub get

### 3. Configure variáveis de ambiente .env
Crie um arquivo .env na raiz do projeto com a sua chave de API do OpenAI:

ini
Copiar
Editar
OPENAI_API_KEY=sua-chave-aqui
⚠️ Nunca comite esse arquivo no GitHub! Adicione .env ao seu .gitignore.

📂 Estrutura de Diretórios
css
Copiar
Editar
lib/
├── models/
│   └── book_model.dart
│   └── study_model.dart
├── pages/
│   └── login_page.dart
│   └── home_page.dart
│   └── chapter_page.dart
│   └── library_page.dart
├── services/
│   └── bible_api_service.dart
│   └── firestore_service.dart
│   └── auth_service.dart
├── firebase_options.dart
└── main.dart
