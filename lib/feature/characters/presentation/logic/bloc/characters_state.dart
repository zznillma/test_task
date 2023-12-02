part of 'characters_bloc.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final CharacterModel characterModel;

  CharactersLoadedState({required this.characterModel});
}

class CharactersLoadingState extends CharactersState {}

class CharactersErrorState extends CharactersState {}

class SearchByNameLoadedState extends CharactersState {
  final CharacterModel characterModel;

  SearchByNameLoadedState({required this.characterModel});
}

class SearchByNameErrorState extends CharactersState {}
