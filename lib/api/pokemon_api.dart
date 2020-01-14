import 'package:flutter/foundation.dart';
import 'package:pixelmon_space/constants.dart';

import 'models/pokemon_models.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<PokemonListEntry>> fetchPokemons(http.Client client) async {
  final response = await client.get(API_URL + "pokemon");

  return compute(parsePokemons, response.body);
}

List<PokemonListEntry> parsePokemons(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  var a =
      parsed.map<PokemonListEntry>((json) => PokemonListEntry.fromJson(json));
  return a.toList();
}
