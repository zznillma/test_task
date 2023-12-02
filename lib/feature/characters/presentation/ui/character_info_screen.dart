import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/feature/characters/data/models/character_model.dart';
import 'package:test_task/internal/helpers/utils.dart';

class CharacterInfoScreen extends StatelessWidget {
  final CharacterResult characterResult;

  const CharacterInfoScreen({
    super.key,
    required this.characterResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(characterResult.name.toString()),
            Text(
              statusConvert(characterResult.status ?? Status.UNKNOWN),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              genderConvert(characterResult.gender ?? Gender.UNKNOWN),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
