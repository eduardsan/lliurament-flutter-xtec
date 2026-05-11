import 'dart:io';

import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_card.dart';
import '../viewmodels/pokemon_viewmodel.dart';
import 'pokemon_edit_page.dart';

class PokemonDetailsPage extends StatefulWidget {
  final PokemonCardEntity pokemon;
  final PokemonViewModel viewModel;

  const PokemonDetailsPage({
    super.key,
    required this.pokemon,
    required this.viewModel,
  });

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late PokemonCardEntity _pokemon;

  @override
  void initState() {
    super.initState();
    _pokemon = widget.pokemon;
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminació'),
          content: Text('Estàs segur que vols eliminar a ${_pokemon.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel·lar'),
            ),
            TextButton(
              onPressed: () {
                if (_pokemon.id != null) {
                  widget.viewModel.deleteCard(_pokemon.id!);
                }
                Navigator.of(context).pop(); // Closes the dialog
                Navigator.of(context).pop(); // Returns to the list
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(_pokemon.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedPokemon = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonEditPage(
                    pokemon: _pokemon,
                    viewModel: widget.viewModel,
                  ),
                ),
              );
              if (updatedPokemon != null &&
                  updatedPokemon is PokemonCardEntity) {
                setState(() {
                  _pokemon = updatedPokemon;
                });
              }
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
                  tag: 'pokemon-${_pokemon.id}',
                  child: Image.file(
                    File(_pokemon.imageUrl),
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _pokemon.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: _pokemon.types
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
