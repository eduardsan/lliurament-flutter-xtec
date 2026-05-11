import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lliurament_flutter_xtec/presentation/pages/pokemon_about_page.dart';
import 'package:lliurament_flutter_xtec/presentation/pages/pokemon_details_page.dart';
import 'package:lliurament_flutter_xtec/presentation/pages/pokemon_edit_page.dart';
import 'package:lliurament_flutter_xtec/presentation/viewmodels/pokemon_viewmodel.dart';

enum HomeMenuAction {
  loadFromAssets,
  deleteAll,
  settings,
  about,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.viewModel});

  final String title;
  final PokemonViewModel viewModel;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/pokeball.png', // Assuming pokeball.png exists in assets/images
            fit: BoxFit.contain,
          ),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonEditPage(
                    viewModel: widget.viewModel,
                  ),
                ),
              );
            },
            tooltip: 'Afegir Pokemon',
          ),
          PopupMenuButton<HomeMenuAction>(
            onSelected: (value) {
              switch (value) {
                case HomeMenuAction.loadFromAssets:
                  widget.viewModel.initialLoad();
                  break;
                case HomeMenuAction.deleteAll:
                  widget.viewModel.deleteAll();
                  break;
                case HomeMenuAction.about:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PokemonAboutPage()),
                  );
                  break;
                case HomeMenuAction.settings:
                  // Add logic for 'Settings' if needed
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<HomeMenuAction>(
                value: HomeMenuAction.loadFromAssets,
                child: Text('Càrrega inicial'),
              ),
              const PopupMenuItem<HomeMenuAction>(
                value: HomeMenuAction.deleteAll,
                child: Text('Eliminar tots'),
              ),
              const PopupMenuDivider(),
              // TODO: maybe add later
              // const PopupMenuItem<HomeMenuAction>(
              //   value: HomeMenuAction.settings,
              //   child: Text('Configuració'),
              // ),
              const PopupMenuItem<HomeMenuAction>(
                value: HomeMenuAction.about,
                child: Text('Sobre'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            if (widget.viewModel.isLoading && widget.viewModel.cards.isEmpty) {
              return const CircularProgressIndicator();
            }
            if (widget.viewModel.cards.isEmpty) {
              return const Text('No hi ha pokemons disponibles.');
            }
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: widget.viewModel.cards.length,
              itemBuilder: (context, index) {
                final pokemon = widget.viewModel.cards[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailsPage(
                            pokemon: pokemon,
                            viewModel: widget.viewModel,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                              tag: 'pokemon-${pokemon.id}',
                              child: Image.file(
                                File(pokemon.imageUrl),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, size: 40),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          pokemon.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                          child: Text(
                            pokemon.types.join(', '),
                            style:
                                const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
