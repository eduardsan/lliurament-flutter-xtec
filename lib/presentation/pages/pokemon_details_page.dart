import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_card.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonCardEntity pokemon;

  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pokemon.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Implement delete logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Hero(
                  tag: 'pokemon-${pokemon.id}',
                  child: Image.asset(
                    pokemon.imageUrl,
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                pokemon.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: pokemon.types
                    .map((type) => Chip(label: Text(type)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}