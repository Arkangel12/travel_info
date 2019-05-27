// To parse this JSON data, do
//
//     final locationSearch = locationSearchFromJson(jsonString);

import 'dart:convert';

List<LocationSearch> locationSearchFromJson(String str) => new List<LocationSearch>.from(json.decode(str).map((x) => LocationSearch.fromJson(x)));

String locationSearchToJson(List<LocationSearch> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class LocationSearch {
  String title;
  String locationType;
  int woeid;
  String lattLong;

  LocationSearch({
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
  });

  factory LocationSearch.fromJson(Map<String, dynamic> json) => new LocationSearch(
    title: json["title"],
    locationType: json["location_type"],
    woeid: json["woeid"],
    lattLong: json["latt_long"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location_type": locationType,
    "woeid": woeid,
    "latt_long": lattLong,
  };
}
