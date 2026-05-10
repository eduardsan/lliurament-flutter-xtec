import 'dart:io';

import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_card.dart';
import '../viewmodels/pokemon_viewmodel.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonCardEntity pokemon;
  final PokemonViewModel viewModel;

  const PokemonDetailsPage({
    super.key,
    required this.pokemon,
    required this.viewModel,
  });

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminació'),
          content: Text('Estàs segur que vols eliminar a ${pokemon.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel·lar'),
            ),
            TextButton(
              onPressed: () {
                if (pokemon.id != null) {
                  viewModel.deleteCard(pokemon.id!);
                }
                Navigator.of(context).pop(); // Closes the dialog
                Navigator.of(context).pop(); // Returns to the list
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

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
              _showDeleteConfirmation(context);
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
                  child: Image.file(
                    File(pokemon.imageUrl),
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