import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_card.dart';
import '../../domain/usecases/add_card.dart';
import '../../domain/usecases/delete_card.dart';
import '../../domain/usecases/get_cards.dart';

class PokemonViewModel extends ChangeNotifier {
  final GetCards getCardsUseCase;
  final AddCard addCardUseCase;
  final DeleteCard deleteCardUseCase;

  PokemonViewModel({
    required this.getCardsUseCase,
    required this.addCardUseCase,
    required this.deleteCardUseCase,
  });

  List<PokemonCardEntity> cards = [];

  Future<void> loadCards() async {
    cards = await getCardsUseCase();
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
}