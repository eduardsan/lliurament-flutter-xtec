// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lliurament_flutter_xtec/main.dart';
import 'package:lliurament_flutter_xtec/data/datasources/local/app_database.dart';
import 'package:lliurament_flutter_xtec/data/datasources/local/image_storage_service.dart';
import 'package:lliurament_flutter_xtec/data/repositories/pokemon_repository_impl.dart';
import 'package:lliurament_flutter_xtec/data/repositories/initial_data_repository_impl.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/add_card.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/delete_card.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/delete_all_cards.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/get_cards.dart';
import 'package:lliurament_flutter_xtec/domain/usecases/initial_load.dart';
import 'package:lliurament_flutter_xtec/presentation/viewmodels/pokemon_viewmodel.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Setup dependencies similar to main.dart
    final database = AppDatabase();
    final imageStorageService = ImageStorageService();
    final repository = PokemonRepositoryImpl(database, imageStorageService);
    final initialDataRepository = InitialDataRepositoryImpl();

    final viewModel = PokemonViewModel(
      getCardsUseCase: GetCards(repository),
      addCardUseCase: AddCard(repository),
      deleteCardUseCase: DeleteCard(repository),
      initialLoadUseCase: InitialLoad(
        localRepository: repository,
        sourceRepository: initialDataRepository,
      ),
      deleteAllCardsUseCase: DeleteAllCards(repository),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(viewModel: viewModel));

    // Verify that the title is present.
    expect(find.text('Gestió de pokemons'), findsAtLeast(1));
  });
}
