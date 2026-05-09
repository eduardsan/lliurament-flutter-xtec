import '../entities/pokemon_card.dart';
import '../repositories/pokemon_repository.dart';

class GetCards {
  final PokemonRepository repository;

  GetCards(this.repository);

  Future<List<PokemonCardEntity>> call() {
    return repository.getCards();
  }
}