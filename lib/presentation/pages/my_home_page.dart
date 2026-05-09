import 'package:flutter/material.dart';
import 'package:lliurament_flutter_xtec/main.dart'; // Import main.dart to access the global viewModel

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Load cards when the page is first created
    viewModel.loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(),
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
                viewModel.initialLoad(); // Call the initialLoad method from the ViewModel
              } else if (value == 'DeleteAll') {
                viewModel.deleteAll(); // Call the deleteAll method from the ViewModel
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
          listenable: viewModel,
          builder: (context, _) {
            if (viewModel.isLoading && viewModel.cards.isEmpty) {
              return const CircularProgressIndicator();
            }
            if (viewModel.cards.isEmpty) {
              return const Text('No hi ha pokemons disponibles.');
            }
            return ListView.builder(
              itemCount: viewModel.cards.length,
              itemBuilder: (context, index) {
                final pokemon = viewModel.cards[index];
                return ListTile(
                  leading: Image.asset(
                    pokemon.imageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                  title: Text(pokemon.name),
                  subtitle: Text(pokemon.types.join(', ')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
