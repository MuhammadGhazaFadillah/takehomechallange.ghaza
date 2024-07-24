import 'package:take_home_challange_ghaza/data/local/db_helper.dart';
import 'package:take_home_challange_ghaza/data/models/characterModel.dart';
import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';
import 'package:take_home_challange_ghaza/data/datasources/character_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource remoteDatasource;
  final dbHelper = DatabaseHelper();

  CharacterRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return await remoteDatasource.getAllCharacters();
  }

  @override
  Future<CharacterModel> getCharacterDetail(int id) async {
    return await remoteDatasource.getCharacterDetail(id);
  }

  @override
  Future<List<CharacterModel>> searchCharacter(String query) async {
    return await remoteDatasource.searchCharacter(query);
  }

  @override
Future<void> addFavorite(CharacterModel character) async {
  await dbHelper.insertFavorite(character);
}

@override
Future<void> removeFavorite(int id) async {
  await dbHelper.removeFavorite(id);
}

@override
Future<List<CharacterModel>> getFavorites() async {
  return await dbHelper.getFavorites();
}
}
