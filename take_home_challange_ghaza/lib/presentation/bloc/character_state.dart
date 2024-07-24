part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterModel> characters;

  const CharacterLoaded({required this.characters});

  @override
  List<Object> get props => [characters];
}

class CharacterDetailLoaded extends CharacterState {
  final CharacterModel character;

  const CharacterDetailLoaded({required this.character});

  @override
  List<Object> get props => [character];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoritesLoaded extends CharacterState {
  final List<CharacterModel> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}