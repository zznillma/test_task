import 'package:test_task/feature/characters/data/models/character_model.dart';

statusConvert(Status status) {
  switch (status) {
    case Status.ALIVE:
      return "Alive";

    case Status.DEAD:
      return "Dead";

    case Status.UNKNOWN:
      return "Unknown";

    default:
      return "Unknown";
  }
}

genderConvert(Gender gender) {
  switch (gender) {
    case Gender.FEMALE:
      return "Female";

    case Gender.GENDERLESS:
      return "Genderless";

    case Gender.MALE:
      return "Male";

    case Gender.UNKNOWN:
      return "Unknown";

    default:
      return "Unknown";
  }
}

String episodeConvert(String input) {
  // Проверяем, соответствует ли строка ожидаемому формату "S01E01"
  RegExp regex = RegExp(r'^S(\d{2})E(\d{2})$');
  RegExpMatch? match = regex.firstMatch(input);

  if (match != null) {
    int season = int.parse(match.group(1)!);
    int episode = int.parse(match.group(2)!);

    // Формируем строку "Сезон 1 Серия 1"
    String result = 'Сезон $season Серия $episode';
    return result;
  } else {
    // В случае неправильного формата возвращаем исходную строку
    return input;
  }
}
