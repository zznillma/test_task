part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesState {}

final class EpisodesInitial extends EpisodesState {}

class EpisodesLoadedState extends EpisodesState {
  final EpisodeModel episodeModel;

  EpisodesLoadedState({required this.episodeModel});
}

class EpisodesLoadingState extends EpisodesState {}

class EpisodesErrorState extends EpisodesState {}

class SeasonLoadedState extends EpisodesState {
  final EpisodeModel episodeModel;

  SeasonLoadedState({required this.episodeModel});
}

class SeasonErrorState extends EpisodesState {}
