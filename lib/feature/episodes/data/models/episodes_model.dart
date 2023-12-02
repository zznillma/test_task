import 'dart:convert';

class EpisodeModel {
  EpisodeModel({
    this.info,
    this.results,
  });

  Info? info;
  List<EpisodeResult>? results;

  factory EpisodeModel.fromRawJson(String str) =>
      EpisodeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<EpisodeResult>.from(
                json["results"]!.map((x) => EpisodeResult.fromJson(x))),
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

class EpisodeResult {
  EpisodeResult({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  DateTime? created;

  factory EpisodeResult.fromRawJson(String str) => EpisodeResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EpisodeResult.fromJson(Map<String, dynamic> json) => EpisodeResult(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null
            ? []
            : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null
            ? []
            : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}