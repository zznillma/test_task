import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_task/feature/characters/data/models/character_model.dart';
import 'package:test_task/feature/characters/domain/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final Dio _dio = Dio();

  static const String baseUrl = 'https://rickandmortyapi.com/api/';

  @override
  Future<CharacterModel> getAllCharacters(page) async {
    try {
      final response = await _dio.get('${baseUrl}character?page=$page');

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      }
      throw response;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<CharacterModel> getByName(String query, int page) async {
    log(page.toString());
    try {
      final response =
          await _dio.get('${baseUrl}character?page=$page&name=$query');

      log(response.realUri.toString());

      if (response.statusCode == 200) {
        // log(response.data.toString());
        return CharacterModel.fromJson(response.data);
      }
      throw response;
    } catch (error) {
      throw error;
    }
  }
}
