import 'package:test_task/feature/characters/data/models/character_model.dart';

abstract class CharacterRepository {
  Future<CharacterModel> getAllCharacters(int page);
  Future<CharacterModel> getByName(String query, int page);
}
