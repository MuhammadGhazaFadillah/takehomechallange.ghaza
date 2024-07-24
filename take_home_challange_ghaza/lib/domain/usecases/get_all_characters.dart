import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';
import 'package:take_home_challange_ghaza/data/models/characterModel.dart';

class GetAllCharacters {
  final CharacterRepository repository;
  GetAllCharacters(this.repository);
  Future<List<CharacterModel>> call(){
    return repository.getAllCharacters();
  }
}