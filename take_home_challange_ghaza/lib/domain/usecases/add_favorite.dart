import 'package:take_home_challange_ghaza/data/models/character.dart';
import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';

class AddFavorite {
  final CharacterRepository repository;
  AddFavorite(this.repository);
  Future<void> call(CharacterModel character) {
    return repository.addFavorite(character);
  }
}