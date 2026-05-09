import '../repositories/pokemon_repository.dart';

class DeleteCard {
  final PokemonRepository repository;

  DeleteCard(this.repository);

  Future<void> call(int id) {
    return repository.deleteCard(id);
  }
}