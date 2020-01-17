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

  var a =
      parsed.map<PokemonListEntry>((json) => PokemonListEntry.fromJson(json));
  return a.toList();
}
