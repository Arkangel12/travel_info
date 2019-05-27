// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) => new List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  String name;
  List<String> topLevelDomain;
  String alpha2Code;
  String alpha3Code;
  List<String> callingCodes;
  String capital;
  List<String> altSpellings;
  String region;
  String subregion;
  int population;
  List<double> latlng;
  String demonym;
  double area;
  double gini;
  List<String> timezones;
  List<String> borders;
  String nativeName;
  String numericCode;
  List<Currency> currencies;
  List<Language> languages;
  Translations translations;
  String flag;
  List<RegionalBloc> regionalBlocs;
  String cioc;

  Country({
    this.name,
    this.topLevelDomain,
    this.alpha2Code,
    this.alpha3Code,
    this.callingCodes,
    this.capital,
    this.altSpellings,
    this.region,
    this.subregion,
    this.population,
    this.latlng,
    this.demonym,
    this.area,
    this.gini,
    this.timezones,
    this.borders,
    this.nativeName,
    this.numericCode,
    this.currencies,
    this.languages,
    this.translations,
    this.flag,
    this.regionalBlocs,
    this.cioc,
  });

  factory Country.fromJson(Map<String, dynamic> json) => new Country(
    name: json["name"],
    topLevelDomain: new List<String>.from(json["topLevelDomain"].map((x) => x)),
    alpha2Code: json["alpha2Code"],
    alpha3Code: json["alpha3Code"],
    callingCodes: new List<String>.from(json["callingCodes"].map((x) => x)),
    capital: json["capital"],
    altSpellings: new List<String>.from(json["altSpellings"].map((x) => x)),
    region: json["region"],
    subregion: json["subregion"],
    population: json["population"],
    latlng: new List<double>.from(json["latlng"].map((x) => x)),
    demonym: json["demonym"],
    area: json["area"],
    gini: json["gini"],
    timezones: new List<String>.from(json["timezones"].map((x) => x)),
    borders: new List<String>.from(json["borders"].map((x) => x)),
    nativeName: json["nativeName"],
    numericCode: json["numericCode"],
    currencies: new List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    languages: new List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    translations: Translations.fromJson(json["translations"]),
    flag: json["flag"],
    regionalBlocs: new List<RegionalBloc>.from(json["regionalBlocs"].map((x) => RegionalBloc.fromJson(x))),
    cioc: json["cioc"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "topLevelDomain": new List<dynamic>.from(topLevelDomain.map((x) => x)),
    "alpha2Code": alpha2Code,
    "alpha3Code": alpha3Code,
    "callingCodes": new List<dynamic>.from(callingCodes.map((x) => x)),
    "capital": capital,
    "altSpellings": new List<dynamic>.from(altSpellings.map((x) => x)),
    "region": region,
    "subregion": subregion,
    "population": population,
    "latlng": new List<dynamic>.from(latlng.map((x) => x)),
    "demonym": demonym,
    "area": area,
    "gini": gini,
    "timezones": new List<dynamic>.from(timezones.map((x) => x)),
    "borders": new List<dynamic>.from(borders.map((x) => x)),
    "nativeName": nativeName,
    "numericCode": numericCode,
    "currencies": new List<dynamic>.from(currencies.map((x) => x.toJson())),
    "languages": new List<dynamic>.from(languages.map((x) => x.toJson())),
    "translations": translations.toJson(),
    "flag": flag,
    "regionalBlocs": new List<dynamic>.from(regionalBlocs.map((x) => x.toJson())),
    "cioc": cioc,
  };
}

class Currency {
  String code;
  String name;
  String symbol;

  Currency({
    this.code,
    this.name,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => new Currency(
    code: json["code"],
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "symbol": symbol,
  };
}

class Language {
  String iso6391;
  String iso6392;
  String name;
  String nativeName;

  Language({
    this.iso6391,
    this.iso6392,
    this.name,
    this.nativeName,
  });

  factory Language.fromJson(Map<String, dynamic> json) => new Language(
    iso6391: json["iso639_1"],
    iso6392: json["iso639_2"],
    name: json["name"],
    nativeName: json["nativeName"],
  );

  Map<String, dynamic> toJson() => {
    "iso639_1": iso6391,
    "iso639_2": iso6392,
    "name": name,
    "nativeName": nativeName,
  };
}

class RegionalBloc {
  String acronym;
  String name;
  List<String> otherAcronyms;
  List<String> otherNames;

  RegionalBloc({
    this.acronym,
    this.name,
    this.otherAcronyms,
    this.otherNames,
  });

  factory RegionalBloc.fromJson(Map<String, dynamic> json) => new RegionalBloc(
    acronym: json["acronym"],
    name: json["name"],
    otherAcronyms: new List<String>.from(json["otherAcronyms"].map((x) => x)),
    otherNames: new List<String>.from(json["otherNames"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "acronym": acronym,
    "name": name,
    "otherAcronyms": new List<dynamic>.from(otherAcronyms.map((x) => x)),
    "otherNames": new List<dynamic>.from(otherNames.map((x) => x)),
  };
}

class Translations {
  String de;
  String es;
  String fr;
  String ja;
  String it;
  String br;
  String pt;
  String nl;
  String hr;
  String fa;

  Translations({
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
    this.br,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
  });

  factory Translations.fromJson(Map<String, dynamic> json) => new Translations(
    de: json["de"],
    es: json["es"],
    fr: json["fr"],
    ja: json["ja"],
    it: json["it"],
    br: json["br"],
    pt: json["pt"],
    nl: json["nl"],
    hr: json["hr"],
    fa: json["fa"],
  );

  Map<String, dynamic> toJson() => {
    "de": de,
    "es": es,
    "fr": fr,
    "ja": ja,
    "it": it,
    "br": br,
    "pt": pt,
    "nl": nl,
    "hr": hr,
    "fa": fa,
  };
}
