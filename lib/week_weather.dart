import 'dart:ui';

import 'package:flutter/material.dart';

class WeekWeather extends StatelessWidget {
  const WeekWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(left: 65, top: 34),
            child: Text(
              "Прогноз на неделю",
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24, fontWeight: FontWeight.w600),
                  ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      body: Column(
        children: [
          Container(
            height: 387,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: getGradiendColor(Theme.of(context).colorScheme.brightness)
              )
            ),
            margin: EdgeInsets.fromLTRB(20, 32, 20, 40),
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('23 сентября',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                  Image.asset('images/partly_cloudy.png', width: 85, height: 76),
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: Row(
                      children: [
                        getIcon("thermometer 1", Theme.of(context).colorScheme.brightness),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('8', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                        ),
                        Text('˚c', style: TextStyle(color: Theme.of(context).textTheme.headline6!.color, fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: Row(
                      children: [
                        getIcon("breeze 1", Theme.of(context).colorScheme.brightness),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('9', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                        ),
                        Text('м/с', style: TextStyle(color: Theme.of(context).textTheme.headline6!.color, fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: Row(
                      children: [
                        getIcon("humidity 1", Theme.of(context).colorScheme.brightness),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('87', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                        ),
                        Text('%', style: TextStyle(color: Theme.of(context).textTheme.headline6!.color, fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: Row(
                      children: [
                        getIcon("barometer 1", Theme.of(context).colorScheme.brightness),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('761', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                        ),
                        Text('мм.рт.ст', style: TextStyle(color: Theme.of(context).textTheme.headline6!.color, fontSize: 16, fontWeight: FontWeight.w600))
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
                border: Border.all(color: Theme.of(context).primaryColor)
            ),
            child:
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            },
                style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary, elevation: 0),
                child: Text(
                  'Вернуться на главную',
                  style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                )
            ),
          )
        ],
      ),
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
}