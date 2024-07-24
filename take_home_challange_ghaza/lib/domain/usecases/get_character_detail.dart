import 'package:take_home_challange_ghaza/data/models/characterModel.dart';
import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';

class GetCharacterDetail {
  final CharacterRepository repository;
  GetCharacterDetail(this.repository);
  Future<CharacterModel> call(int id){
    return repository.getCharacterDetail(id);
  }
}