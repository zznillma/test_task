import 'dart:convert';

class CharacterModel {
  CharacterModel({
    this.info,
    this.results,
  });

  Info? info;
  List<CharacterResult>? results;

  factory CharacterModel.fromRawJson(String str) =>
      CharacterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<CharacterResult>.from(
                json["results"]!.map((x) => CharacterResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  int? count;
  int? pages;
  String? next;
  dynamic prev;

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class CharacterResult {
  CharacterResult({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  int? id;
  String? name;
  Status? status;
  Species? species;
  String? type;
  Gender? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  factory CharacterResult.fromRawJson(String str) =>
      CharacterResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterResult.fromJson(Map<String, dynamic> json) =>
      CharacterResult(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]] ?? Species.HUMAN,
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin:
            json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode":
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

// ignore: constant_identifier_names
enum Gender { GENDERLESS, MALE, FEMALE, UNKNOWN }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "unknown": Gender.UNKNOWN,
  "Genderless": Gender.GENDERLESS,
});

class Location {
  Location({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Species {
  HUMANOID,
  CRONENBERG,
  ROBOT,
  MYTHOLOGICAL_CREATURE,
  HUMAN,
  ALIEN,
  MALE
}

final speciesValues = EnumValues({
  "Alien": Species.ALIEN,
  "Human": Species.HUMAN,
  "Humanoid": Species.HUMANOID,
  "Mythological Creature": Species.MYTHOLOGICAL_CREATURE,
  'Cronenberg': Species.CRONENBERG,
  'Robot': Species.ROBOT,
});

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
