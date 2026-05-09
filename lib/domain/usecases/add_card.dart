import '../entities/pokemon_card.dart';
import '../repositories/pokemon_repository.dart';

class AddCard {
  final PokemonRepository repository;

  AddCard(this.repository);

  Future<void> call(PokemonCardEntity card) {
    return repository.addCard(card);
  }
}