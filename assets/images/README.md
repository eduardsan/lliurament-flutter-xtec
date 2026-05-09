# Pokémon sprites

Official artwork sprites downloaded from the public
[PokeAPI/sprites](https://github.com/PokeAPI/sprites) repository
(`sprites/pokemon/other/official-artwork/{id}.png`).

These images are the property of Nintendo / Game Freak / The Pokémon Company
and are used here strictly for **non-commercial educational purposes**
within the context of this Flutter course.

## Included pokemon (id → name)

| Id | Name | Type |
|----|------|------|
| 1  | Bulbasaur  | Grass / Poison |
| 2  | Ivysaur    | Grass / Poison |
| 3  | Venusaur   | Grass / Poison |
| 4  | Charmander | Fire |
| 5  | Charmeleon | Fire |
| 6  | Charizard  | Fire / Flying |
| 7  | Squirtle   | Water |
| 8  | Wartortle  | Water |
| 9  | Blastoise  | Water |
| 25 | Pikachu    | Electric |
| 39 | Jigglypuff | Normal / Fairy |
| 52 | Meowth     | Normal |
| 54 | Psyduck    | Water |
| 58 | Growlithe  | Fire |
| 63 | Abra       | Psychic |
| 74 | Geodude    | Rock / Ground |
| 92 | Gastly     | Ghost / Poison |
| 129| Magikarp   | Water |
| 132| Ditto      | Normal |
| 143| Snorlax    | Normal |
| 150| Mewtwo     | Psychic |
| 151| Mew        | Psychic |

## How to add more

```bash
ID=149  # Dragonite
curl -o "assets/images/${ID}.png" \
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${ID}.png"
```

Then make sure `assets/images/` is declared in `pubspec.yaml` (see Day 2).
