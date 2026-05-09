class PokemonCardEntity {
  final int? id;
  final String name;
  final String type;
  final String imageUrl;

  PokemonCardEntity({
    this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });
}