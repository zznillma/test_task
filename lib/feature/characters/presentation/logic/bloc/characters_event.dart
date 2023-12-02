// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_bloc.dart';

@immutable
sealed class CharactersEvent {}

class GetAllCharactersEvent extends CharactersEvent {
  final bool isFirstCall;
  final int page;

  GetAllCharactersEvent({
    required this.isFirstCall,
    required this.page,
  });
}

class GetByNameEvent extends CharactersEvent {
  bool isFirstCall;
  final int page;
  final String query;

  GetByNameEvent({
    required this.isFirstCall,
    required this.page,
    required this.query,
  });
}
