import 'package:take_home_challange_ghaza/domain/repositories/character_repo.dart';

class RemoveFavorite {
  final CharacterRepository repository;
  RemoveFavorite(this.repository);
  Future<void> call(int id) {
    return repository.removeFavorite(id);
  }
}