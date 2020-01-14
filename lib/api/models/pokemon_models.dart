class PokeAggression {
  int timid;
  int passive;
  int aggressive;

  PokeAggression(this.timid, this.passive, this.aggressive);

  factory PokeAggression.fromJson(json) {
    return PokeAggression(json["timid"] as int, json["passive"] as int,
        json["aggressive"] as int);
  }
}

class PokeEvolution {
  int level;
  String name;
  int form;
  Map<String, dynamic> conditions;
  List<String> moves;
  String evoType;

  PokeEvolution(this.level, this.name, this.form, this.conditions, this.moves,
      this.evoType);

  factory PokeEvolution.fromJson(json) {
    return PokeEvolution(
        json["level"] as int,
        json["name"] as String,
        json["form"] as int,
        json["conditions"] as Map<String, dynamic>,
        json["moves"] as List<String>,
        json["evoType"] as String);
  }
}

class PokeStats {
  int hp;
  int attack;
  int defence;
  int speed;
  int specialAttack;
  int specialDefence;

  PokeStats(this.hp, this.attack, this.defence, this.speed, this.specialAttack,
      this.specialDefence);

  factory PokeStats.fromJson(json) {
    return PokeStats(
        json["HP"] as int,
        json["Attack"] as int,
        json["Defence"] as int,
        json["Speed"] as int,
        json["SpecialAttack"] as int,
        json["SpecialDefence"] as int);
  }
}

class Pokemon {
  int id;
  String pixelmonName;
  String pokemon;
  PokeStats stats;
  int catchRate;
  int malePercent;
  int spawnLevel;
  String spawnLevelRange;
  int baseExp;
  int baseFriendship;
  List<String> types;
  double height;
  double width;
  double length;
  bool isRideable;
  bool canFly;
  bool canSurf;
  List<String> preEvolutions;
  String experienceGroup;
  PokeAggression aggression;
  List<String> spawnLocations;
  Map<String, int> evYields;
  int weight;
  List<PokeEvolution> evolutions;
  List<String> abilities;
  List<String> eggGroups;
  int eggCycles;
  Map<String, List<String>> levelUpMoves;
  List<String> tmMoves;
  List<String> tutorMoves;
  List<String> eggMoves;
  Map<String, Pokemon> forms;
  int form;

  Pokemon(
      this.id,
      this.pixelmonName,
      this.pokemon,
      this.stats,
      this.catchRate,
      this.malePercent,
      this.spawnLevel,
      this.spawnLevelRange,
      this.baseExp,
      this.baseFriendship,
      this.types,
      this.height,
      this.width,
      this.length,
      this.isRideable,
      this.canFly,
      this.canSurf,
      this.preEvolutions,
      this.experienceGroup,
      this.aggression,
      this.spawnLocations,
      this.evYields,
      this.weight,
      this.evolutions,
      this.abilities,
      this.eggGroups,
      this.eggCycles,
      this.levelUpMoves,
      this.tmMoves,
      this.tutorMoves,
      this.eggMoves,
      this.forms,
      this.form);

  factory Pokemon.fromJson(json) {
    Map<String, Pokemon> forms = new Map();
    Map<String, dynamic> origForms = json["forms"] as Map<String, dynamic>;
    origForms.forEach((name, val) {
      forms[name] = Pokemon.fromJson(val);
    });
    return Pokemon(
        json["id"] as int,
        json["pixelmonName"] as String,
        json["pokemon"] as String,
        PokeStats.fromJson(json["stats"]),
        json["catchRate"] as int,
        json["malePercent"] as int,
        json["spawnLevel"] as int,
        json["spawnLevelRange"] as String,
        json["baseExp"] as int,
        json["baseFriendship"] as int,
        json["types"] as List<String>,
        json["height"] as double,
        json["width"] as double,
        json["length"] as double,
        json["isRideable"] as bool,
        json["canFly"] as bool,
        json["canSurf"] as bool,
        json["preEvolutions"] as List<String>,
        json["experienceGroup"] as String,
        PokeAggression.fromJson(json["aggression"]),
        json["spawnLocations"] as List<String>,
        json["evYields"] as Map<String, int>,
        json["weight"] as int,
        (json["evolutions"] as List<dynamic>).map((o) =>
            PokeEvolution.fromJson(o)).toList(),
        json["abilities"] as List<String>,
        json["eggGroups"] as List<String>,
        json["eggCycles"] as int,
        json["levelUpMoves"] as Map<String, List<String>>,
        json["tmMoves"] as List<String>,
        json["tutorMoves"] as List<String>,
        json["eggMoves"] as List<String>,
        forms,
        json["form"] as int);
  }
}

class PokemonListEntry {
  String pixelmonName;
  int id;
  List<String> types;
  PokeStats stats;

  PokemonListEntry(this.pixelmonName, this.id, this.types, this.stats);

  factory PokemonListEntry.fromJson(json) {
    return PokemonListEntry(json["pixelmonName"] as String, json["id"] as int,
        (json["types"] as List<dynamic>).map((o) => o as String).toList(),
        PokeStats.fromJson(json["stats"]));
  }
}
