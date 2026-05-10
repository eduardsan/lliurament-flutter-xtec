import 'package:flutter/material.dart';
import 'package:lliurament_flutter_xtec/presentation/pages/pokemon_details_page.dart';
import 'package:lliurament_flutter_xtec/presentation/viewmodels/pokemon_viewmodel.dart';

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
            onPressed: () {}, // Logic for adding a single card can be added here
            tooltip: 'Increment',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'LoadFromAssets') {
                widget.viewModel.initialLoad();
              } else if (value == 'DeleteAll') {
                widget.viewModel.deleteAll();
              }
              // Add logic for 'Settings' and 'About' if needed
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'LoadFromAssets',
                child: Text('Càrrega inicial'),
              ),
              const PopupMenuItem<String>(
                value: 'DeleteAll',
                child: Text('Eliminar tots'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Configuració'),
              ),
              const PopupMenuItem<String>(
                value: 'About',
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
                          builder: (context) =>
                              PokemonDetailsPage(pokemon: pokemon),
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
                              child: Image.asset(
                                pokemon.imageUrl,
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
