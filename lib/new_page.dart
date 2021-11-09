import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/week_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/weather.dart';
import 'package:http/http.dart' as http;
import 'debounce.dart';


String lat = "59.931";
String lon = "30.360";
String city_name = "Saint Petersburg";
final cities  = <CityModel>[];

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var _controller = TextEditingController();
  final debouncer = Debouncer(milliseconds: 2000);

  List<CityModel> getCities(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CityModel>((json) => CityModel.fromJson(json)).toList();
  }
  Future<List<CityModel>> fetchCity(String val) async {

    final response = await http
        .get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$val&limit=10&appid=5afa0f095e31e5b72e0d15b4c0dbeed4'));
    if (response.statusCode == 200) {
      return getCities(response.body);
    } else {
      throw Exception('Failed to load list');
    }
  }
  void callCity(String val) async {
    var cityList = await fetchCity(val);
    setState(() {
      cities.clear();
      cities.addAll(cityList);
    });
  }

  Future<void> mainCity(CityModel city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jsonCity = jsonEncode(city.toJson());
    await preferences.setString('main_city', jsonCity);
  }

  Future<void> saveCity(CityModel city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cities = await preferences.getStringList('favourites') ?? [];
    cities.add(jsonEncode(city.toJson()));
    await preferences.setStringList('favourites', cities);
  }

  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: (
                        ){
                      Navigator
                          .of(context)
                          .push(
                          MaterialPageRoute(builder: (_) => MyHomePage())
                      );
                     },
                    child: Icon(Icons.arrow_back_ios),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      onPrimary: Theme.of(context).colorScheme.surface,
                    shape: CircleBorder(),
                    elevation: 0
                  )
                ),
                Container(
                  height: 50,
                  width: 250,
                child:
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Введите название города...',
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline3!.color,
                          fontSize: 15),
                    ),
                    showCursor: true,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 13
                    ),
                    textInputAction: TextInputAction.search,
                    onChanged: (val) {
                      debouncer.run(callCity, val);
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(226, 235, 255, 1.0),
                    onPrimary: Color.fromRGBO(50, 50, 50, 1.0),
                    shape: CircleBorder(),
                    elevation: 0
                  ),
                    onPressed: (){
                    _controller.clear();
                    },
                    child: Icon(Icons.clear),

                )
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(minHeight: 10, maxHeight: MediaQuery.of(context).size.height / 3),
              child: ListView.separated(
                itemCount: cities.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    width: MediaQuery.of(context).size.width - 30,
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    height: 25,
                    child: Row (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 5,
                            child:
                            GestureDetector(
                              onTap: () => {mainCity(cities[index]).then((value) => Navigator
                                  .of(context)
                                  .push(
                                  MaterialPageRoute(builder: (_) => MyHomePage())
                              ))},
                              child: Text(
                                cities[index].localName.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600
                                ),

                              ),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: StarButton(
                            iconSize: 30,
                            iconColor: Theme.of(context).primaryColor,
                            valueChanged: (is_Favorite) {
                              saveCity(cities[index]).then((value) => null);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, position) {
                  return Divider();
                },
              )
          ),
        ],
      )
    );
  }
}