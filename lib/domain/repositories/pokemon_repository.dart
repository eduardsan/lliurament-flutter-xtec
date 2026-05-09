import '../entities/pokemon_card.dart';

abstract class PokemonRepository {
  Future<List<PokemonCardEntity>> getCards();

  Future<void> addCard(PokemonCardEntity card);

  Future<void> addCards(List<PokemonCardEntity> cards);

  Future<void> deleteCard(int id);

  Future<void> deleteAllCards();
}