import 'package:dio/dio.dart';
import 'package:test_task/feature/episodes/data/models/episodes_model.dart';
import 'package:test_task/feature/episodes/domain/repository/episode_repository.dart';

class EpisodesRepositoryImpl implements EpisodeRepository {
  final Dio _dio = Dio();

  static const String baseUrl = 'https://rickandmortyapi.com/api/';

  @override
  Future<EpisodeModel> getAllEpisodes(pages) async {
    try {
      Response response = await _dio.get('${baseUrl}episode?page=$pages');

      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EpisodeModel> getSeason(String season) async {
    try {
      Response response = await _dio.get('${baseUrl}episode/?episode=$season');

      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw e;
    }
  }
}
