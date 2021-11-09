import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  List<CityModel> favCity = [];

  Future<void> initFavourite() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var favourites = preferences.getStringList('favourites');
    setState(() {
      for (String favourite in favourites!){
        var decode = jsonDecode(favourite);
        favCity.add(new CityModel(name: decode['name'],
            localName: decode['local_names'],
            lat: decode['lat'], lon: decode['lon']));
      }
    });
  }
  Future<void> deleteFavCity(CityModel city) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var favourites = preferences.getStringList('favourites');
    for (int i=0; i<favourites!.length; i++){
      var decode = jsonDecode(favourites[i]);
      if(city.lat==decode['lat'] && city.lon==decode['lon']){
        favourites.removeAt(i);
        break;
      }
    }
    await preferences.setStringList('favourites', favourites);
    setState(() {
      favCity.remove(city);
    });
  }

  Future<void> mainCity(CityModel city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var jsonCity = jsonEncode(city.toJson());
    await preferences.setString('main_city', jsonCity);
  }

  @override
  void initState(){
    initFavourite().then((value) => {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          elevation: 0,
          leading: ElevatedButton(
            onPressed: (){
              Navigator
                  .of(context)
                  .push(
                  MaterialPageRoute(builder: (_) => MyHomePage())
              );
            },
            child: Icon(Icons.arrow_back_ios),
            style: ElevatedButton.styleFrom(
                primary: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
                onPrimary: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                elevation: 0
            ),
          ),
          title: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text('Избранное', style: TextStyle(color: Theme
                      .of(context)
                      .primaryColor),)
              ),
            ],
          ),
          titleTextStyle: TextStyle(fontSize: 20, color: Theme
              .of(context)
              .primaryColor, fontWeight: FontWeight.bold),
        ),
        body: Container(
          decoration: BoxDecoration(color: Theme
              .of(context)
              .colorScheme
              .secondary),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 32, 20, 0),
            child: getFavCity(favCity, Theme
                .of(context)
                .colorScheme
                .brightness)
          ),
        )
    );
  }

  ListView getFavCity(List<CityModel> city, Brightness brightness) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: city.length,
        itemBuilder: (BuildContext context, int index) {
          if (brightness == Brightness.light) {
            return
              Container(
                  width: 320,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(222, 233, 255, 1.0),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            offset: Offset(0, 4),
                            spreadRadius: 5,
                            blurRadius: 4
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:  () => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyHomePage())),
                          mainCity(city[index])
                          },
                  child:
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 20),
                        child: Text(city[index].localName.toString(), style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),),
                      )),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 218, 255, 1.0),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(
                                      200, 218, 255, 1.0)),
                              onPressed: () {
                                deleteFavCity(city[index]);
                                setState(() {

                                });
                              },
                              child: Image.asset('images/close.png')
                          ),
                        ),
                      ),
                    ],
                  )
              );
          }
          else {
            return
            Container(
                width: 320,
                height: 50,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(13, 23, 43, 1.0),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.13),
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                          blurRadius: 5
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                        offset: Offset(0, -4),
                        blurRadius: 10
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                    onTap:  () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyHomePage())),
            mainCity(city[index])
            },
              child:
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(city[index].localName.toString(), style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),),
                    )),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(21, 42, 83, 1.0),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(21, 42, 83, 1.0)),
                            onPressed: () {
                              deleteFavCity(city[index]);
                              setState(() {

                              });
                            },
                            child: Image.asset('images/close_dark.png')
                        ),
                      ),
                    ),

                  ],
                )
            );
          }
        }
    );
  }
}