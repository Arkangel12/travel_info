// To parse this JSON data, do
//
//     final localization = localizationFromJson(jsonString);

import 'dart:convert';

Localization localizationFromJson(String str) => Localization.fromJson(json.decode(str));

String localizationToJson(Localization data) => json.encode(data.toJson());

class Localization {
  List<dynamic> consolidatedWeather;
  DateTime time;
  DateTime sunRise;
  DateTime sunSet;
  String timezoneName;
  Parent parent;
  List<dynamic> sources;
  String title;
  String locationType;
  int woeid;
  String lattLong;
  String timezone;

  Localization({
    this.consolidatedWeather,
    this.time,
    this.sunRise,
    this.sunSet,
    this.timezoneName,
    this.parent,
    this.sources,
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
    this.timezone,
  });

  factory Localization.fromJson(Map<String, dynamic> json) => new Localization(
    consolidatedWeather: new List<dynamic>.from(json["consolidated_weather"].map((x) => x)),
    time: DateTime.parse(json["time"]),
    sunRise: DateTime.parse(json["sun_rise"]),
    sunSet: DateTime.parse(json["sun_set"]),
    timezoneName: json["timezone_name"],
    parent: Parent.fromJson(json["parent"]),
    sources: new List<dynamic>.from(json["sources"].map((x) => x)),
    title: json["title"],
    locationType: json["location_type"],
    woeid: json["woeid"],
    lattLong: json["latt_long"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "consolidated_weather": new List<dynamic>.from(consolidatedWeather.map((x) => x)),
    "time": time.toIso8601String(),
    "sun_rise": sunRise.toIso8601String(),
    "sun_set": sunSet.toIso8601String(),
    "timezone_name": timezoneName,
    "parent": parent.toJson(),
    "sources": new List<dynamic>.from(sources.map((x) => x)),
    "title": title,
    "location_type": locationType,
    "woeid": woeid,
    "latt_long": lattLong,
    "timezone": timezone,
  };
}

class Parent {
  Parent();

  factory Parent.fromJson(Map<String, dynamic> json) => new Parent(
  );

  Map<String, dynamic> toJson() => {
  };
}
