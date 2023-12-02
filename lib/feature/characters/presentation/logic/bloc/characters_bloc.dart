import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/feature/characters/data/models/character_model.dart';
import 'package:test_task/feature/characters/domain/character_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharacterRepository repository;
  CharactersBloc(this.repository) : super(CharactersInitial()) {
    on<GetAllCharactersEvent>((event, emit) async {
      if (event.isFirstCall) {
        emit(CharactersLoadingState());
      }

      await repository
          .getAllCharacters(event.page)
          .then((value) => emit(CharactersLoadedState(characterModel: value)))
          .onError((error, stackTrace) => CharactersErrorState());
    });

    on<GetByNameEvent>((event, emit) async {
      if (event.isFirstCall) {
        emit(CharactersLoadingState());
      }

      await repository
          .getByName(event.query!, event.page)
          .then((value) => emit(SearchByNameLoadedState(characterModel: value)))
          .onError((error, stackTrace) => emit(SearchByNameErrorState()));
    });
  }
}
