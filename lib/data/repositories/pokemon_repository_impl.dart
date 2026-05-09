import '../../domain/entities/pokemon_card.dart';
import '../../domain/repositories/pokemon_repository.dart';

import '../datasources/local/app_database.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final AppDatabase database;

  PokemonRepositoryImpl(this.database);

  @override
  Future<void> addCard(PokemonCardEntity card) async {
    try {
      await database.insertCard(
        PokemonCardsCompanion.insert(
          name: card.name,
          type: card.type,
          secondType: card.secondType,
          imageUrl: card.imageUrl,
        ),
      );
    } catch (e) {
      // Log error or rethrow a domain-specific exception
      rethrow;
    }
  }

  @override
  Future<void> deleteCard(int id) async {
    await database.deleteCard(id);
  }

  @override
  Future<List<PokemonCardEntity>> getCards() async {
    final cards = await database.getAllCards();

    return cards.map((card) {
      return PokemonCardEntity(
        id: card.id,
        name: card.name,
        type: card.type,
        secondType: card.secondType,
        imageUrl: card.imageUrl,
      );
    }).toList();
  }
}