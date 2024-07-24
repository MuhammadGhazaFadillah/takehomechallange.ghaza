part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetCharactersEvent extends CharacterEvent {}

class GetCharacterDetailEvent extends CharacterEvent {
  final int id;

  const GetCharacterDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchCharactersEvent extends CharacterEvent {
  final String query;

  const SearchCharactersEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class AddFavoriteEvent extends CharacterEvent {
  final CharacterModel character;

  const AddFavoriteEvent({required this.character});

  @override
  List<Object> get props => [character];
}

class RemoveFavoriteEvent extends CharacterEvent {
  final int id;

  const RemoveFavoriteEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetFavoritesEvent extends CharacterEvent {}