import 'package:drift/drift.dart';

class PokemonCards extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get type => text()();

  TextColumn get secondType => text()();

  TextColumn get imageUrl => text()();
}