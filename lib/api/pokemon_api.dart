import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pixelmon_space/constants.dart';

import 'models/pokemon_models.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<PokemonListEntry>> fetchPokemons(http.Client client) async {
  final file = await DefaultCacheManager().getSingleFile(API_URL + "pokemon");
  return compute(parsePokemons, await file.readAsString());
}

List<PokemonListEntry> parsePokemons(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PokemonListEntry>((json) => PokemonListEntry.fromJson(json))
      .toList();
}

Future<Pokemon> fetchPokemon(http.Client client, int id) async {
  final file =
  await DefaultCacheManager().getSingleFile(API_URL + "pokemon/$id");
  return compute(parsePokemon, await file.readAsString());
}

Pokemon parsePokemon(String responseBody) {
  var parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return Pokemon.fromJson(parsed);
}
