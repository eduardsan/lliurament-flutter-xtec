import 'package:drift/drift.dart';
import '../../domain/entities/pokemon_card.dart';
import '../../domain/repositories/pokemon_repository.dart';

import '../datasources/local/image_storage_service.dart';
import '../datasources/local/app_database.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final AppDatabase database;
  final ImageStorageService imageStorageService;

  PokemonRepositoryImpl(this.database, this.imageStorageService);

  @override
  Future<void> addCard(PokemonCardEntity card) async {
    final String finalImageUrl = await imageStorageService.saveImage(card.imageUrl);

    await database.into(database.pokemonCards).insertOnConflictUpdate(
          PokemonCardsCompanion(
            id: card.id != null ? Value(card.id!) : const Value.absent(),
            name: Value(card.name),
            type: Value(card.type),
            secondType: Value(card.secondType),
            imageUrl: Value(finalImageUrl),
          ),
        );
  }

  @override
  Future<void> addCards(List<PokemonCardEntity> cards) async {
    // Prepare companions outside the batch to keep heavy async I/O 
    // (copying files) out of the database transaction.
    final List<PokemonCardsCompanion> companions = await Future.wait(
      cards.map((card) async {
        final String finalImageUrl =
            await imageStorageService.saveImage(card.imageUrl);
        return PokemonCardsCompanion(
          id: card.id != null ? Value(card.id!) : const Value.absent(),
          name: Value(card.name),
          type: Value(card.type),
          secondType: Value(card.secondType),
          imageUrl: Value(finalImageUrl),
        );
      }).toList(),
    );

    await database.batch((batch) {
      batch.insertAll(
        database.pokemonCards,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> deleteCard(int id) async {
    final card = await database.getCardById(id);
    if (card != null) {
      final absolutePath = await imageStorageService.resolvePath(card.imageUrl);
      await imageStorageService.deleteImage(absolutePath);
    }
    await database.deleteCard(id);
  }

  @override
  Future<void> deleteAllCards() async {
    await imageStorageService.deleteAllImages();
    await database.deleteAllCards();
  }

  @override
  Future<List<PokemonCardEntity>> getCards() async {
    final cards = await database.getAllCards();

    return Future.wait(cards.map((card) async {
      return PokemonCardEntity(
        id: card.id,
        name: card.name,
        type: card.type,
        secondType: card.secondType,
        imageUrl: await imageStorageService.resolvePath(card.imageUrl),
      );
    }));
  }
}