// RF007 — Tela Home com ListView de produtos
// Responsável: Botoloto

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/produto_provider.dart';
import '../../utils/app_routes.dart';
import '../../widgets/produto_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Garantias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Alertas',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.alertas),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.sobre),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, _) {
          if (provider.produtos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Nenhum produto cadastrado ainda.',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: provider.produtos.length,
            itemBuilder: (context, index) {
              return ProdutoCard(produto: provider.produtos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.cadastrarProduto),
        icon: const Icon(Icons.add),
        label: const Text('Novo produto'),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final usuario = auth.usuarioLogado;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue, size: 32),
                ),
                const SizedBox(height: 10),
                Text(usuario?.nome ?? '', style: const TextStyle(color: Colors.white, fontSize: 16)),
                Text(usuario?.email ?? '', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Início'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Alertas de vencimento'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.alertas);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.sobre);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {
              auth.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
