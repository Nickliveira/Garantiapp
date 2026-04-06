# GarantiApp 🛡️

Aplicativo Flutter para gerenciamento de garantias e notas fiscais.

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

## Equipe

- **Nicolas Oliveira** — Líder técnico, Setup, RF001, Cadastrar e Detalhe produto
- **Felipe Fragiorgis** — RF002, RF003, RF004, Editar produto, RF006
- **Enzo Botoloto** — Modelo Usuario, RF007 (Home + Cards), Alertas, Excluir, Navegação, README
