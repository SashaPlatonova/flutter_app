import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';

class Weather {
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int pressure;
  final String image;
  final String time;
  final String location;

  Weather(
      {required this.name,
         required this.day,
         required this.wind,
         required this.humidity,
         required this.pressure,
         required this.image,
         required this.current,
         required this.time,
         required this.location}
        );

}

String appId = "5afa0f095e31e5b72e0d15b4c0dbeed4";

String findIcon(String name){
  switch(name){
    case "Clouds":
      return "rain3";
      break;
    case "Rain":
      return "rain";
      break;
    case "Drizzle":
      return "rain3";
      break;
    case "Thunderstorm":
      return "moln";
      break;
    case "Clear":
      return "sun";
      break;
    default:
      return "sun";
  }
}

String weekIcon(String name){
  switch(name){
    case "Clouds":
      return "clody";
      break;
    case "Rain":
      return "rainy";
      break;
    case "Drizzle":
      return "rainy";
      break;
    case "Thunderstorm":
      return "thnderstorm";
      break;
    case "Clear":
      return "slight_touch_happyday";
      break;
    case "Snow": return "snowy";
    default:
      return "sun";
  }
}

Future<List> fetchData(String lat, String lon, String city) async {
  var url = "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var current = res["current"];
    Weather currentTemp = Weather(
        name: current["weather"][0]["main"].toString(),
        day: DateFormat.yMMMd('ru').format(date),
        wind: current["wind_speed"]?.round() ?? 0,
        humidity: current["humidity"]?.round() ?? 0,
        pressure: current["pressure"]?.round() ?? 0,
        image: findIcon(current["weather"][0]["main"].toString()),
        current: current["temp"]?.round() ?? 0,
        time: "",
        location: city
    );

    List<Weather> todayWeather = [];
    int hour = int.parse(DateFormat.H('ru').format(date));
    for (var j = 0; j < 13; j+=3) {
      int i = hour+j;
      if(i>23){
        i = i-24;
      }
      var temp = res["hourly"];
      var hourly = Weather(name: "",
          location: city,
          day: "",
          wind: temp[i]["wind_speed"]?.round() ?? 0,
          humidity: temp[i]["humidity"]?.round() ?? 0,
          pressure: temp[i]["pressure"]?.round() ?? 0,
          current: temp[i]["temp"]?.round() ?? 0,
          image: findIcon(temp[i]["weather"][0]["main"].toString()),
          time: Duration(hours: i).toString().split(":")[0] + ":00"
      );
      todayWeather.add(hourly);
    }
    List<Weather> sevenDay = [];
    for(var i=0;i<8;i++){
      String day = DateFormat.MMMMd('ru').format(date);
      var temp = res["daily"][i];
      var hourly = Weather(
          current: temp["temp"]["day"]?.round() ?? 0,
          pressure: temp["pressure"]?.round() ?? 0,
          humidity: temp["humidity"]?.round() ?? 0,
          wind: temp["wind_speed"]?.round() ?? 0,
          location: city,
          image:weekIcon(temp["weather"][0]["main"].toString()),
          name:temp["weather"][0]["main"].toString(),
          day: day,
          time:""
      );
      sevenDay.add(hourly);
    }
    return [currentTemp, todayWeather, sevenDay];
  }
  return [null, null, null];
}

class CityModel{
  final String name;
  final String lat;
  final String lon;
  CityModel({required this.name,required this.lat,required this.lon});
}

var cityJSON;

Future<CityModel?> fetchCity(String cityName) async{
  if(cityJSON==null){
    String link = "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
    var response = await http.get(Uri.parse(link));
    if(response.statusCode==200){
      cityJSON = json.decode(response.body);
    }
  }
  for(var i=0;i<cityJSON.length;i++){
    if(cityJSON[i]["name"].toString().toLowerCase() == cityName.toLowerCase()){
      return CityModel(
          name:cityJSON[i]["name"].toString(),
          lat: cityJSON[i]["latitude"].toString(),
          lon: cityJSON[i]["longitude"].toString()
      );
    }
  }
  return null;
}


