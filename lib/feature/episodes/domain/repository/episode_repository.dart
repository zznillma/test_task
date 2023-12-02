import 'package:test_task/feature/episodes/data/models/episodes_model.dart';

abstract class EpisodeRepository {
  Future<EpisodeModel> getAllEpisodes(int pages);
  Future<EpisodeModel> getSeason(String season);
}
