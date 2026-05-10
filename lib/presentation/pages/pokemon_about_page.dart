import 'package:flutter/material.dart';

class PokemonAboutPage extends StatelessWidget {
  const PokemonAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sobre'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/pokeball.png',
                height: 120,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Gestió de Pokemons',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Versió 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Aquesta aplicació és un projecte educatiu per al lliurament del curs Desenvolupament d\'Apps Multiplataforma amb Flutter de l\'XTEC.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            _buildInfoSection(
              context,
              title: 'Arquitectura',
              description: 'MVVM (Model-View-ViewModel) amb Clean Architecture.',
            ),
            _buildInfoSection(
              context,
              title: 'Persistència',
              description: 'Base de dades local SQLite utilitzant la llibreria Drift.',
            ),
            _buildInfoSection(
              context,
              title: 'Crèdits',
              description: 'Imatges i dades obtingudes de PokeAPI.',
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Desenvolupat per Eduard Santamaria',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context,
      {required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}