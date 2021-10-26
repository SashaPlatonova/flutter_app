import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          leading: ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Theme.of(context).colorScheme.surface,
              elevation: 0
            ),
          ),
          title: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text('О разработчике', style: TextStyle(color: Theme.of(context).primaryColor),)
              ),
            ],
          ),
          titleTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        ),
      body: Container(
        margin: EdgeInsets.only(top: 143, left: 76),
        width: 224,
        height: 52,
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.onSurface,
            boxShadow: weatherShadow(Theme.of(context).colorScheme.brightness),
          borderRadius: BorderRadius.circular(10)
        ),
          child: Center(
            child: Text(
            'Weather app',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          color: Theme.of(context).primaryColor
        )
      ),
          )
        ),
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.secondary,
      child:
      Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: bottomShadow(Theme.of(context).colorScheme.brightness)
        ),
        height: 346,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
                child: Text('by ITMO University', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Theme.of(context).primaryColor)
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
                child: Text('Версия 1.0', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: Theme.of(context).colorScheme.onBackground)
                )
            ),
            Container(
                padding: EdgeInsets.only(top: 8),
                child: Text('от 30 сентября 2021', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: Theme.of(context).colorScheme.onBackground)
                )
            ),
            Container(
                padding: EdgeInsets.only(top: 241),
                child: Text('2021', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: Theme.of(context).primaryColor)
                )
            ),
          ],
        ),
      ),
    ));
  }
  
  List<BoxShadow> weatherShadow(Brightness brightness){
    if (brightness == Brightness.dark){
        return [BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0
        ),
        BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 10
        )
      ];
    }
    return [BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.05),
        offset: Offset(0, 4),
        blurRadius: 4,
        spreadRadius: 0
    ),
      BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.05),
          offset: Offset(0, -4),
          spreadRadius: 0,
          blurRadius: 4
      )
    ];

  }
  
  List<BoxShadow> bottomShadow (Brightness brightness){
    if (brightness == Brightness.dark){
     return  [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.07),
          offset: Offset(0, -6),
          spreadRadius: 0,
          blurRadius: 8
      ),
       BoxShadow(
         offset: Offset(0, -4),
         color: Color.fromRGBO(255, 255, 255, 0.15),
         blurRadius: 10
       )
     ];
    }
    return [BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        offset: Offset(0, -6),
        spreadRadius: 0,
        blurRadius: 28
    )];
  }
}