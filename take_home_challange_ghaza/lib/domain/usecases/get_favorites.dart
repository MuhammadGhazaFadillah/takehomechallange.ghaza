import 'package:take_home_challange_ghaza/data/models/character.dart';
import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';

class GetFavorites {
  final CharacterRepository repository;
  GetFavorites(this.repository);
  Future<List<CharacterModel>> call() {
    return repository.getFavorites();
  }
}