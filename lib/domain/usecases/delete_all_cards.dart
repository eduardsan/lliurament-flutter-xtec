import '../repositories/pokemon_repository.dart';

class DeleteAllCards {
  final PokemonRepository repository;

  DeleteAllCards(this.repository);

  Future<void> call() async {
    await repository.deleteAllCards();
  }
}