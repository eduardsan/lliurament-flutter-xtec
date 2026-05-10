import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/pokemon_card.dart';
import '../../domain/repositories/initial_data_repository.dart';

class InitialDataRepositoryImpl implements InitialDataRepository {
  @override
  Future<List<PokemonCardEntity>> getInitialPokemon() async {
    try {
      // Implementation details like rootBundle and JSON decoding live here
      final String response = await rootBundle.loadString('assets/data/individus.json');
      final Map<String, dynamic> jsonMap = json.decode(response);
      final List<dynamic> pokemonList = jsonMap['pokemon'] ?? [];

      return pokemonList.map((item) {
        return PokemonCardEntity(
          id: item['id'],
          name: item['name'] ?? 'Unknown',
          type: item['type'] ?? 'Normal',
          secondType: item['secondaryType'] ?? '',
          imageUrl: 'assets/images/${item['id']}.png',
        );
      }).toList();
    } catch (e) {
      // The implementation handles the specific error context
      throw Exception('Failed to load initial data from assets: $e');
    }
  }
}