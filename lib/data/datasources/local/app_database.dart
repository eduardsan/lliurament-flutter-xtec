import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/pokemon_cards_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [PokemonCards])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CREATE
  Future<int> insertCard(PokemonCardsCompanion card) {
    return into(pokemonCards).insert(card);
  }

  // READ
  Future<List<PokemonCard>> getAllCards() {
    return select(pokemonCards).get();
  }

  // BULK DELETE
  Future<int> deleteAllCards() {
    return delete(pokemonCards).go();
  }

  // DELETE
  Future<int> deleteCard(int id) {
    return (delete(pokemonCards)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(
      p.join(dbFolder.path, 'pokemon.sqlite'),
    );

    return NativeDatabase(file);
  });
}