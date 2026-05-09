import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_card.dart';
import '../../domain/usecases/add_card.dart';
import '../../domain/usecases/delete_card.dart';
import '../../domain/usecases/get_cards.dart';
import '../../domain/usecases/initial_load.dart'; // Import the InitialLoad use case
import '../../domain/usecases/delete_all_cards.dart'; // Import the DeleteAllCards use case

class PokemonViewModel extends ChangeNotifier {
  final GetCards getCardsUseCase;
  final AddCard addCardUseCase;
  final DeleteCard deleteCardUseCase;
  final InitialLoad initialLoadUseCase; // Add InitialLoad as a dependency
  final DeleteAllCards deleteAllCardsUseCase; // Add DeleteAllCards as a dependency

  PokemonViewModel({
    required this.getCardsUseCase,
    required this.addCardUseCase,
    required this.deleteCardUseCase,
    required this.initialLoadUseCase, // Make it required
    required this.deleteAllCardsUseCase, // Make it required
  });

  List<PokemonCardEntity> cards = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCards() async {
    _isLoading = true;
    notifyListeners();

    cards = await getCardsUseCase();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCard(PokemonCardEntity card) async {
    await addCardUseCase(card);
    await loadCards();
  }

  Future<void> deleteCard(int id) async {
    await deleteCardUseCase(id);
    await loadCards();
  }

  // New method to trigger initial data load
  Future<void> initialLoad() async {
    await initialLoadUseCase();
    await loadCards(); // Reload cards after initial load
  }

  // New method to trigger deleting all cards
  Future<void> deleteAll() async {
    await deleteAllCardsUseCase();
    await loadCards(); // Reload cards after deleting all
  }
}