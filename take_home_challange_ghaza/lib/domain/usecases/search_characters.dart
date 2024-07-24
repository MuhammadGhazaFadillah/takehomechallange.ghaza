import 'package:take_home_challange_ghaza/data/models/characterModel.dart';
import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';

class SearchCharacters {
  final CharacterRepository repository;
  SearchCharacters(this.repository);
  Future<List<CharacterModel>> call(String query){
    return repository.searchCharacter(query);
  }
}