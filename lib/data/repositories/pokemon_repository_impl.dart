import 'package:drift/drift.dart';
import '../../domain/entities/pokemon_card.dart';
import '../../domain/repositories/pokemon_repository.dart';

import '../datasources/local/app_database.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final AppDatabase database;

  PokemonRepositoryImpl(this.database);

  @override
  Future<void> addCard(PokemonCardEntity card) async {
    await database.into(database.pokemonCards).insertOnConflictUpdate(
          PokemonCardsCompanion(
            id: card.id != null ? Value(card.id!) : const Value.absent(),
            name: Value(card.name),
            type: Value(card.type),
            secondType: Value(card.secondType),
            imageUrl: Value(card.imageUrl),
          ),
        );
  }

  @override
  Future<void> addCards(List<PokemonCardEntity> cards) async {
    await database.batch((batch) {
      batch.insertAll(
        database.pokemonCards,
        cards
            .map((card) => PokemonCardsCompanion(
                  id: card.id != null ? Value(card.id!) : const Value.absent(),
                  name: Value(card.name),
                  type: Value(card.type),
                  secondType: Value(card.secondType),
                  imageUrl: Value(card.imageUrl),
                ))
            .toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> deleteCard(int id) async {
    await database.deleteCard(id);
  }

  @override
  Future<void> deleteAllCards() async {
    await database.deleteAllCards();
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