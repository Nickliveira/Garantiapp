// Configuração central do app: tema, rotas e providers
// Responsável: Nicolas

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/produto_provider.dart';
import 'utils/app_routes.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/cadastro_screen.dart';
import 'screens/auth/esqueceu_senha_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/produto/cadastrar_produto_screen.dart';
import 'screens/produto/detalhe_produto_screen.dart';
import 'screens/produto/editar_produto_screen.dart';
import 'screens/alertas/alertas_screen.dart';
import 'screens/sobre/sobre_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProdutoProvider()),
      ],
      child: MaterialApp(
        title: 'GarantiApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.cadastro: (_) => const CadastroScreen(),
          AppRoutes.esqueceuSenha: (_) => const EsqueceuSenhaScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.cadastrarProduto: (_) => const CadastrarProdutoScreen(),
          AppRoutes.detalheProduto: (_) => const DetalheProdutoScreen(),
          AppRoutes.editarProduto: (_) => const EditarProdutoScreen(),
          AppRoutes.alertas: (_) => const AlertasScreen(),
          AppRoutes.sobre: (_) => const SobreScreen(),
        },
      ),
    );
  }
}
