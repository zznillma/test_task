part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesEvent {}

class GetAllEpisodesEvent extends EpisodesEvent {
  final int pages;
  final bool isFirstCall;

  GetAllEpisodesEvent({
    required this.pages,
    required this.isFirstCall,
  });
}

class GetSeasonEvent extends EpisodesEvent {
  final String season;

  GetSeasonEvent({required this.season});
}
