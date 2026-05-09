import 'package:flutter/material.dart';
import 'package:lliurament_flutter_xtec/data/datasources/local/app_database.dart';
import 'package:lliurament_flutter_xtec/data/repositories/pokemon_repository_impl.dart';
import 'package:lliurament_flutter_xtec/data/repositories/initial_data_repository_impl.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/add_card.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/delete_card.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/delete_all_cards.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/get_cards.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/initial_load.dart';
import 'package:lliurament_flutter_xtec/presentation/pages/my_home_page.dart';
import 'package:lliurament_flutter_xtec/presentation/viewmodels/pokemon_viewmodel.dart';

final database = AppDatabase();

final repository = PokemonRepositoryImpl(database);
final initialDataRepository = InitialDataRepositoryImpl();

final initialLoadUseCase = InitialLoad(
  localRepository: repository,
  sourceRepository: initialDataRepository,
);
final deleteAllCardsUseCase = DeleteAllCards(repository);

final viewModel = PokemonViewModel(
  getCardsUseCase: GetCards(repository),
  addCardUseCase: AddCard(repository),
  deleteCardUseCase: DeleteCard(repository),
  initialLoadUseCase: initialLoadUseCase, // Pass the initialLoadUseCase
  deleteAllCardsUseCase: deleteAllCardsUseCase, // Pass the deleteAllCardsUseCase
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestió de pokemons',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFCB05), // Pokemon Yellow
          primary: const Color(0xFFFFCB05),
          secondary: const Color(0xFF3B4CCA), // Pokemon Blue
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gestió de pokemons'),
    );
  }
}
