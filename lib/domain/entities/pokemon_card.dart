class PokemonCardEntity {
  final int? id;
  final String name;
  final String type;
  final String secondType;
  final String imageUrl;

  PokemonCardEntity({
    this.id,
    required this.name,
    required this.type,
    required this.secondType,
    required this.imageUrl,
  });

  List<String> get types {
    return [
      type,
      if (secondType.isNotEmpty && secondType.toLowerCase() != 'none') secondType,
    ];
  }
}