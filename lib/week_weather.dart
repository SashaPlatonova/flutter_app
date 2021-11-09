import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/settings_values.dart';
import 'package:flutter_app/weather.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:shared_preferences/shared_preferences.dart';

String lat = "59.931";
String lon = "30.360";
String city = "Saint Petersburg";
List<Weather> sevenWeather = [];
int temp = 0;
int pressure = 0;
int speed = 0;
Units? units;

class WeekWeather extends StatefulWidget {
  const WeekWeather({Key? key}) : super(key: key);

  @override
  State<WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<WeekWeather> {

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
        () => 'Data Loaded',
  );

  getData() async{
    fetchData(lat, lon, city).then((value){
      sevenWeather = value[2];
      getUnits();
      setState(() {
      });
    });
  }
  Future<void> getUnits() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      temp = preferences.getInt('temp')?? 0;
      pressure = preferences.getInt('pressure')?? 0;
      speed = preferences.getInt('speed')?? 0;
      units = Units(t: temp, s: speed, p: pressure);
      units!.initValues();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child =
                Scaffold(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  appBar: AppBar(
                    title: Container(
                      padding: EdgeInsets.only(left: 65, top: 34),
                      child: Text(
                        "Прогноз на неделю",
                        style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                  ),
                  body: Container(
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 387,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: getGradiendColor(Theme
                                            .of(context)
                                            .colorScheme
                                            .brightness)
                                    )
                                ),
                                margin: EdgeInsets.fromLTRB(20, 32, 20, 40),
                                child: Container(
                                  margin: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(sevenWeather[index].day,
                                        style: TextStyle(fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Theme
                                                .of(context)
                                                .primaryColor),),
                                      Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: getDayIcon(
                                              sevenWeather[index].image)),
                                      Container(
                                        margin: EdgeInsets.only(top: 45),
                                        child: Row(
                                          children: [
                                            getIcon("thermometer 1", Theme
                                                .of(context)
                                                .colorScheme
                                                .brightness),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(units!.parseTemp(
                                                sevenWeather[index].current),
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor),),
                                            ),
                                            Text(units!.parseTempName(),
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w600))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 26),
                                        child: Row(
                                          children: [
                                            getIcon("breeze 1", Theme
                                                .of(context)
                                                .colorScheme
                                                .brightness),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(units!.parseSpeed(
                                                sevenWeather[index].wind),
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor),),
                                            ),
                                            Text(units!.parseSpeedName(),
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w600))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 26),
                                        child: Row(
                                          children: [
                                            getIcon("humidity 1", Theme
                                                .of(context)
                                                .colorScheme
                                                .brightness),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                sevenWeather[index].humidity
                                                    .toString(),
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor),),
                                            ),
                                            Text('%',
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w600))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 26),
                                        child: Row(
                                          children: [
                                            getIcon("barometer 1", Theme
                                                .of(context)
                                                .colorScheme
                                                .brightness),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(units!.parsePressure(
                                                sevenWeather[index].pressure),
                                                style: TextStyle(fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor),),
                                            ),
                                            Text(units!.parsePressureName(),
                                                style: TextStyle(color: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w600))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Theme
                                        .of(context)
                                        .primaryColor)
                                ),
                                child:
                                ElevatedButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                    style: ElevatedButton.styleFrom(
                                        primary: Theme
                                            .of(context)
                                            .colorScheme
                                            .onPrimary, elevation: 0),
                                    child: Text(
                                      'Вернуться на главную',
                                      style: TextStyle(
                                          fontSize: 14, color: Theme
                                          .of(context)
                                          .primaryColor),
                                    )
                                ),
                              )
                            ],
                          );
                        },
                        itemCount: 7,

                      )
                  ),
                );
          }
          else {
            child = child = Scaffold(
              backgroundColor: Color.fromRGBO(226, 235, 255, 1.0),
              body: Center(
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: MediaQuery
                              .of(context)
                              .size
                              .height / 4),
                          child: Text(
                            'Weather',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w600),
                          )
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
              ),
            );
          }
          return Container(
            child: child,
          );
        }
    );
  }

  List<Color> getGradiendColor(Brightness brightness){
    if(brightness == Brightness.dark){
      return [
        Color.fromRGBO(34, 59, 112, 1.0),
        Color.fromRGBO(15, 31, 64, 1.0)
      ];
    }
    return [
      Color.fromRGBO(205, 218, 245, 1.0),
      Color.fromRGBO(156, 188, 255, 1.0)
    ];
  }

  Image getIcon(String _icon, Brightness brightness) {
    String path = 'images/';
    if (brightness == Brightness.dark){
      _icon += '_dark';
    }
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 24,
      height: 24,
    );
  }

  Image getDayIcon(String _icon) {
    String path = 'images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 85,
      height: 76,
    );
  }
}