import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/data/local/db_helper.dart';
import 'package:take_home_challange_ghaza/domain/usecases/add_favorite.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_all_characters.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_character_detail.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_favorites.dart';
import 'package:take_home_challange_ghaza/domain/usecases/remove_favorite.dart';
import 'package:take_home_challange_ghaza/domain/usecases/search_characters.dart';
import 'package:take_home_challange_ghaza/data/models/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharacters getAllCharacters;
  final GetCharacterDetail getCharacterDetail;
  final SearchCharacters searchCharacters;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorites getFavorites;
  final DatabaseHelper databaseHelper;

  CharacterBloc({
    required this.getAllCharacters,
    required this.getCharacterDetail,
    required this.searchCharacters,
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavorites,
    required this.databaseHelper,
  }) : super(CharacterInitial()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characters = await getAllCharacters();
        emit(CharacterLoaded(characters: characters));
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });

    on<GetCharacterDetailEvent>((event, emit) async {
      emit(CharacterLoading());
      try {
        final character = await getCharacterDetail(event.id);
        emit(CharacterDetailLoaded(character: character));
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });

    on<SearchCharactersEvent>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characters = await searchCharacters(event.query);
        emit(CharacterLoaded(characters: characters));
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      try {
        await databaseHelper.insert(event.character);
        add(GetFavoritesEvent());
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      try {
        await databaseHelper.delete(event.id);
        add(GetFavoritesEvent());
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });

    on<GetFavoritesEvent>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characters = await databaseHelper.queryAllFavorites();
        emit(CharacterLoaded(characters: characters));
      } catch (e) {
        emit(CharacterError(message: e.toString()));
      }
    });
  }
}