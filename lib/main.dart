
import 'package:flutter/material.dart';
import 'package:flutter_app/about_app.dart';
import 'package:flutter_app/favorites.dart';
import 'package:flutter_app/settings.dart';
import 'package:flutter_app/theme/config.dart';
import 'package:flutter_app/theme/custom_theme.dart';
import 'package:flutter_app/weather.dart';
import 'package:flutter_app/week_weather.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'new_page.dart';

Weather? currentWeather;
List<Weather> todayWeather = [];
String lat = "59.931";
String lon = "30.360";
String city = "Saint Petersburg";
void main() {
  initializeDateFormatting('ru', null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme, //3
      darkTheme: CustomTheme.darkTheme, //4
      themeMode: currentTheme.currentTheme,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  getData() async{
    fetchData(lat, lon, city).then((value){
      currentWeather = value[0];
      todayWeather = value[1];
      setState(() {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        Widget child;
        if(snapshot.hasData){
          child =
      Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: ListView(
            padding: EdgeInsets.only(top: 30),
            children: <Widget> [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Weather app',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)
                    ),
                  ]
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (){
                          Navigator
                              .of(context)
                              .push(
                              MaterialPageRoute(builder: (_) => Settings())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                            onPrimary: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                            elevation: 0
                        ),
                        child: Icon(Icons.settings)
                    ),
                    Text('Настройки', style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor
                    ),
                    )
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (){
                          Navigator
                              .of(context)
                              .push(
                              MaterialPageRoute(builder: (_) => (Favorites()))
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                            onPrimary: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                            elevation: 0
                        ),
                        child: Icon(Icons.favorite_border)
                    ),
                    Text('Избранные',  style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor
                    ),)
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (){
                          Navigator
                              .of(context)
                              .push(
                              MaterialPageRoute(builder: (_) => AboutApp())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                            onPrimary: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                            elevation: 0
                        ),
                        child: Icon(Icons.account_circle_outlined)
                    ),
                    Text('О приложении',  style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: ExpandableBottomSheet(
        background:
        Container(
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
                image: DecorationImage(image:  getFonImg(Theme.of(context).primaryColor),
                  fit: BoxFit.cover,)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Theme.of(context).colorScheme.primary,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(Icons.menu),
                ),
                Column(
                  children: <Widget>[
                    TextButton(onPressed:(){
                    },
                      child: Text(
                        currentWeather!.current.toString() + '˚c',
                        style: TextStyle(color: Colors.white, fontSize: 56, letterSpacing: 0.1),
                      ),
                    ),
                    Text(
                      currentWeather!.day,
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(color: Colors.white),
                      primary: Theme.of(context).colorScheme.primary,
                      onPrimary: Colors.white
                  ),
                  onPressed: () {
                    Navigator
                        .of(context)
                        .push(
                        MaterialPageRoute(builder: (_) => Search())
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ],
            )
        ),
        persistentHeader: Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Theme.of(context).colorScheme.secondary
            ),
            child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: headerImg(Theme.of(context).colorScheme.brightness),
                            height: 3,
                            width: 60,
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0),
                      height: 150.0,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 15, bottom: 15, right: 10),
                                margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: BorderRadius.all(Radius.circular(18)),
                                    boxShadow: cardBoxShadow(Theme.of(context).brightness)),
                                child: Column(children: [
                                  Text(
                                    todayWeather[index].time,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  getWeatherIcon('rain3', Theme.of(context).colorScheme.brightness),
                                  Text(
                                    todayWeather[index].current.toString() + '˚c',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ]));
                          })
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Theme.of(context).colorScheme.secondaryVariant)
                    ),
                    child:
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeekWeather())
                      );
                    },
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary, elevation: 0),
                        child: Text(
                          'Прогноз на неделю',
                          style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondaryVariant),
                        )
                    ),
                  ),
                ])
        ),
        expandableContent: Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.fromLTRB(20, 32, 20, 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: cardBoxShadow(Theme.of(context).colorScheme.brightness),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(46, 19, 0, 22),
                                child: Row(
                                  children: [
                                    bottomImage(Theme.of(context).colorScheme.brightness, 'thermometer 1'),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(currentWeather!.current.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    ),
                                    Text('˚c', style: TextStyle(color:Theme.of(context).colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.w600))
                                  ],
                                )
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.fromLTRB(10, 32, 20, 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: cardBoxShadow(Theme.of(context).colorScheme.brightness),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(46, 19, 0, 22),
                                child: Row(
                                  children: [
                                    bottomImage(Theme.of(context).colorScheme.brightness, 'humidity 1'),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(currentWeather!.humidity.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    ),
                                    Text('%', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.w600))
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.fromLTRB(20, 32, 20, 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: cardBoxShadow(Theme.of(context).colorScheme.brightness),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                                margin: EdgeInsets.fromLTRB(46, 19, 0, 22),
                                child: Row(
                                  children: [
                                    bottomImage(Theme.of(context).colorScheme.brightness, 'breeze 1'),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(currentWeather!.wind.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    ),
                                    Text('м/с', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.w600))
                                  ],
                                )
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 65,
                            margin: EdgeInsets.fromLTRB(20, 32, 0, 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                boxShadow: cardBoxShadow(Theme.of(context).colorScheme.brightness),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 4),
                                          child: bottomImage(Theme.of(context).colorScheme.brightness, 'barometer 1')
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text(currentWeather!.pressure.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                                      ),
                                      Text('мм.рт.ст', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
        ),
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
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 4),
                        child: Text(
                          'Weather',
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
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

  Image getWeatherIcon(String _icon, Brightness brightness) {
    String path = 'images/';
    if (brightness == Brightness.dark){
      _icon += '_dark';
    }
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  AssetImage headerImg(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return new AssetImage('images/header_dark.png');
    }
    return new AssetImage('images/header.png');
  }

  AssetImage getFonImg(Color color) {
    String path = 'images/';
    String imageExtension = ".png";
    if (color == Colors.black){
      return new AssetImage(path + 'fon' + imageExtension);
    }
    else {
      return new AssetImage(path + 'fon_dark' + imageExtension);
    }
  }

  List<BoxShadow> cardBoxShadow(Brightness brightness){
    if(brightness == Brightness.dark){

      return [BoxShadow(
          offset: Offset(4, 4),
          blurRadius: 6,
          spreadRadius: 0,
          color: Color.fromRGBO(0, 0, 0, 0.15)
      ),
        BoxShadow(
            offset: Offset(-2, -3),
            blurRadius: 0,
            color: Color.fromRGBO(255, 255, 255, 0.05)
        )];
    }
    return [ BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 20,
        spreadRadius: 0,
        color: Color.fromRGBO(58, 58, 58, 0.1)
    ),
      BoxShadow(
          offset: Offset(0, -5),
          blurRadius: 9,
          color: Color.fromRGBO(255, 255, 255, 0.25)
      )];
  }

  Image bottomImage(Brightness brightness, String _icon){
    if (brightness == Brightness.dark){
      return Image.asset('images/' + _icon + '_dark.png', width: 24, height:24);
    }
    return Image.asset('images/' + _icon + '.png', width: 24, height: 24);
  }

}



