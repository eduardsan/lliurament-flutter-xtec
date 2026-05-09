import '../repositories/pokemon_repository.dart';
import '../repositories/initial_data_repository.dart';

class InitialLoad {
  final PokemonRepository localRepository;
  final InitialDataRepository sourceRepository;

  InitialLoad({
    required this.localRepository,
    required this.sourceRepository,
  });

  Future<void> call() async {
    try {
      final pokemons = await sourceRepository.getInitialPokemon();
      
      await localRepository.addCards(pokemons);
    } catch (e) {
      throw Exception('Error loading initial data: $e');
    }
  }
}
