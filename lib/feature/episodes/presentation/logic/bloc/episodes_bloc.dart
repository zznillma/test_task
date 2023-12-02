import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/feature/episodes/data/models/episodes_model.dart';
import 'package:test_task/feature/episodes/domain/repository/episode_repository.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  EpisodeRepository repository;

  EpisodesBloc(this.repository) : super(EpisodesInitial()) {
    on<GetAllEpisodesEvent>((event, emit) async {
      if (event.isFirstCall) {
        emit(EpisodesLoadingState());
      }

      await repository
          .getAllEpisodes(event.pages)
          .then((value) => emit(EpisodesLoadedState(episodeModel: value)))
          .onError((error, stackTrace) => emit(EpisodesErrorState()));
    });

    on<GetSeasonEvent>((event, emit) async {
      await repository
          .getSeason(event.season)
          .then((value) => emit(SeasonLoadedState(episodeModel: value)))
          .onError((error, stackTrace) => emit(SeasonErrorState()));
    });
  }
}
