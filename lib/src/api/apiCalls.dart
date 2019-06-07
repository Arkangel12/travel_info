
import 'package:demo_meetup/src/models/country.dart';
import 'package:demo_meetup/src/models/localization.dart';
import 'package:demo_meetup/src/models/localizationSearch.dart';
import 'package:http/http.dart' as http;

class ApiCalls {

  Future<List<Country>> getCountries() async {
    var response = await http.get("https://restcountries.eu/rest/v2/all");
    return countryFromJson(response.body);
  }

  Future<List<Country>> getCountriesByName(String name) async {
    var response = await http.get("https://restcountries.eu/rest/v2/name/$name");
    return countryFromJson(response.body);
  }

  Future<Localization> getWeatherOfCapital(String name) async {
    int woeid = 0;
    var response = await http.get("https://www.metaweather.com/api/location/search/?query=$name");
    List<LocationSearch> resultList = locationSearchFromJson(response.body);

    resultList.forEach((result) => woeid = result.woeid);

    response = await http.get("https://www.metaweather.com/api/location/$woeid/");
    print(response.body);

    if(woeid != 0) return localizationFromJson(response.body);
    else return null;

  }
}