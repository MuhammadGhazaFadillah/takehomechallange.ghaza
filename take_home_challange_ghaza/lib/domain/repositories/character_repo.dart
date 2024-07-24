import 'package:take_home_challange_ghaza/data/models/character.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterModel> getCharacterDetail(int id);
  Future<List<CharacterModel>> searchCharacter(String query);
  Future<void> addFavorite(CharacterModel character);
  Future<void> removeFavorite(int id);
  Future<List<CharacterModel>> getFavorites();
}