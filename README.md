# GarantiApp 🛡️

Aplicativo Flutter para gerenciamento de garantias e notas fiscais.

## Como rodar

```bash
flutter pub get
flutter run
```

## Conta de demonstração

| Campo | Valor |
|-------|-------|
| E-mail | `demo@email.com` |
| Senha | `123456` |

## Estrutura do projeto

```
lib/
├── main.dart                    # Ponto de entrada
├── app.dart                     # MaterialApp + rotas + MultiProvider
├── models/
│   ├── produto.dart             # Entidade Produto + enum StatusGarantia
│   └── usuario.dart             # Entidade Usuario
├── providers/
│   ├── auth_provider.dart       # ChangeNotifier — Login, Cadastro, Logout
│   └── produto_provider.dart    # ChangeNotifier — CRUD de produtos
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart           # RF001
│   │   ├── cadastro_screen.dart        # RF002
│   │   └── esqueceu_senha_screen.dart  # RF003
│   ├── home/
│   │   └── home_screen.dart            # RF007 — ListView principal
│   ├── produto/
│   │   ├── cadastrar_produto_screen.dart  # RF005
│   │   ├── detalhe_produto_screen.dart    # RF005
│   │   └── editar_produto_screen.dart     # RF005
│   ├── alertas/
│   │   └── alertas_screen.dart            # RF005
│   └── sobre/
│       └── sobre_screen.dart              # RF004
├── widgets/
│   ├── produto_card.dart         # Card reutilizável com status visual
│   └── custom_text_field.dart    # Campo de texto padronizado
└── utils/
    ├── app_routes.dart           # Constantes de rotas
    └── validators.dart           # Funções de validação reutilizáveis

```

## Requisitos implementados

| RF | Descrição | Peso |
|----|-----------|------|
| RF001 | Login com validação de e-mail e senha | 25% (junto RF002+003) |
| RF002 | Cadastro de usuário com 5 campos e validações | — |
| RF003 | Recuperação de senha (mockada) | — |
| RF004 | Tela Sobre com equipe e informações acadêmicas | 5% |
| RF005 | 5 funcionalidades: Cadastrar, Detalhe, Editar, Alertas, Excluir | 50% |
| RF006 | AlertDialog e SnackBar em todo o app | 5% |
| RF007 | ListView com cards estilizados por status | 15% |

## Equipe

- **Nicolas** — Líder técnico, Setup, RF001, Cadastrar e Detalhe produto
- **Felipe** — RF002, RF003, RF004, Editar produto, RF006
- **Botoloto** — Modelo Usuario, RF007 (Home + Cards), Alertas, Excluir, Navegação, README
