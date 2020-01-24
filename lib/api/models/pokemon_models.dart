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
  List<dynamic> conditions;
  List<String> moves;
  String evoType;
  String from;
  int toID;
  int fromID;

  PokeEvolution(this.level, this.name, this.form, this.conditions, this.moves,
      this.evoType, this.from, this.toID, this.fromID);

  factory PokeEvolution.fromJson(json) {
    return PokeEvolution(
        json["level"] as int,
        json["name"] as String,
        json["form"] as int,
        json["conditions"] as List<dynamic>,
        json["moves"] == null
            ? List()
            : (json["moves"] as List).cast<String>().toList(),
        json["evoType"] as String,
        json["from"],
        json["toID"],
        json["fromID"]);
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

class PokeMove {
  int attackIndex;
  String attackName;
  String attackType;
  String attackCategory;


  PokeMove(this.attackIndex, this.attackName, this.attackType,
      this.attackCategory);

  factory PokeMove.fromJson(json) {
    return PokeMove(
      json["attackIndex"] as int,
      json["attackName"] as String,
      json["attackType"] as String,
      json["attackCategory"] as String,
    );
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
  int spawnLevelRange;
  int baseExp;
  int baseFriendship;
  List<String> types;
  double height;
  double width;
  double length;
  bool isRideable;
  bool canFly;
  bool canSurf;
  String experienceGroup;
  PokeAggression aggression;
  List<String> spawnLocations;
  Map<String, int> evYields;
  double weight;
  List<PokeEvolution> evolutions;
  List<PokeEvolution> prevEvolutions;
  List<PokeEvolution> nextEvolutions;
  List<String> abilities;
  List<String> eggGroups;
  int eggCycles;
  Map<String, List<PokeMove>> levelUpMoves;
  List<PokeMove> tmMoves;
  List<PokeMove> tutorMoves;
  List<PokeMove> eggMoves;
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
      this.experienceGroup,
      this.aggression,
      this.spawnLocations,
      this.evYields,
      this.weight,
      this.evolutions,
      this.prevEvolutions,
      this.nextEvolutions,
      this.abilities,
      this.eggGroups,
      this.eggCycles,
      this.levelUpMoves,
      this.tmMoves,
      this.tutorMoves,
      this.eggMoves,
      this.forms,
      this.form) {
    this.prevEvolutions.sort((PokeEvolution a, PokeEvolution b) =>
    a.toID - b.toID);
    this.nextEvolutions.sort((PokeEvolution a, PokeEvolution b) =>
    a.toID - b.toID);
  }

  factory Pokemon.fromJson(json) {
    Map<String, Pokemon> forms = new Map();
    Map<String, dynamic> origForms = json["forms"] as Map<String, dynamic>;
    if (origForms != null) {
      origForms.forEach((name, val) {
        forms[name] = Pokemon.fromJson(val);
      });
    }
    return Pokemon(
      json["id"],
      json["pixelmonName"],
      json["pokemon"],
      json["stats"] == null
          ? PokeStats(0, 0, 0, 0, 0, 0)
          : PokeStats.fromJson(json["stats"]),
      json["catchRate"],
      json["malePercent"],
      json["spawnLevel"],
      json["spawnLevelRange"],
      json["baseExp"],
      json["baseFriendship"],
      json["types"] == null
          ? List()
          : (json["types"] as List).cast<String>().toList(),
      json["height"] is int
          ? (json["height"] as int).toDouble()
          : json["height"] as double,
      json["width"] is int ? json["width"].toDouble() : json["width"],
      json["length"] is int ? json["length"].toDouble() : json["length"],
      json["isRideable"],
      json["canFly"],
      json["canSurf"],
      json["experienceGroup"],
      json["aggression"] != null
          ? PokeAggression.fromJson(json["aggression"])
          : PokeAggression(0, 0, 0),
      json["spawnLocations"] == null
          ? List()
          : json["spawnLocations"].cast<String>().toList(),
      json["evYields"] == null
          ? Map()
          : (json["evYields"] as Map).cast<String, int>(),
      json["weight"] == null
          ? 0
          : ((json["weight"] is double)
          ? (json["weight"] as double)
          : (json["weight"] as int).toDouble()),
      json["evolutions"] == null
          ? List()
          : (json["evolutions"] as List<dynamic>)
          .map((o) => PokeEvolution.fromJson(o))
          .toList(),
      json["prevEvolutions"] == null
          ? List()
          : (json["prevEvolutions"] as List<dynamic>)
          .map((o) => PokeEvolution.fromJson(o))
          .toList(),
      json["nextEvolutions"] == null
          ? List()
          : (json["nextEvolutions"] as List<dynamic>)
          .map((o) => PokeEvolution.fromJson(o))
          .toList(),
      json["abilities"] == null
          ? List()
          : (json["abilities"] as List).cast<String>().toList(),
      json["eggGroups"] == null
          ? List()
          : (json["eggGroups"] as List).cast<String>().toList(),
      json["eggCycles"],
      json["levelUpMoves"] == null
          ? Map()
          : (json["levelUpMoves"] as Map<String, dynamic>)
          .map((a, b) =>
          MapEntry(a, (b as List).map((o) => PokeMove.fromJson(o)).toList())),
      json["tmMoves"] == null
          ? List()
          : (json["tmMoves"] as List).map((o) => PokeMove.fromJson(o)).toList(),
      json["tutorMoves"] == null
          ? List()
          : (json["tutorMoves"] as List)
          .map((o) => PokeMove.fromJson(o))
          .toList(),
      json["eggMoves"] == null
          ? List()
          : (json["eggMoves"] as List)
          .map((o) => PokeMove.fromJson(o))
          .toList(),
      forms,
      json["form"],
    );
  }
}

class PokemonListEntry {
  String pixelmonName;
  int id;
  List<String> types;
  PokeStats stats;

  PokemonListEntry(this.pixelmonName, this.id, this.types, this.stats);

  factory PokemonListEntry.fromJson(json) {
    return PokemonListEntry(
        json["pixelmonName"] as String,
        json["id"] as int,
        (json["types"] as List<dynamic>).map((o) => o as String).toList(),
        PokeStats.fromJson(json["stats"]));
  }
}
