import '../entities/pokemon_card.dart';

abstract class InitialDataRepository {
  Future<List<PokemonCardEntity>> getInitialPokemon();
}