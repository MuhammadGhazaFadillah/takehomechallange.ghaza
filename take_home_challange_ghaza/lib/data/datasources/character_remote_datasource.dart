import 'package:take_home_challange_ghaza/data/models/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterRemoteDatasource {
  final http.Client client;

  CharacterRemoteDatasource({required this.client});

  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await client.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<CharacterModel> getCharacterDetail(int id) async {
    final response = await client.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CharacterModel.fromJson(data);
    } else {
      throw Exception('Failed to load character details');
    }
  }

  Future<List<CharacterModel>> searchCharacter(String query) async {
    final response = await client.get(Uri.parse('https://rickandmortyapi.com/api/character/?name=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search characters');
    }
  }
}
