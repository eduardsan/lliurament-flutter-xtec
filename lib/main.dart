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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Gestió de pokemons'),
    );
  }
}
