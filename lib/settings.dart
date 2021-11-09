import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_app/theme/config.dart';
import 'package:flutter_app/theme/custom_theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  int temp = 0;
  int speed = 0;
  int pressure = 0;
  int theme = 0;

  @override
  void initState(){
    super.initState();
    initValues().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
    appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Theme.of(context).colorScheme.surface,
              elevation: 0
            ),
            ),
    title: Row(
    children: [
      Container(
      padding: EdgeInsets.only(left: 30),
      child: Text('Настройки')
      ),
      ],
    ),
    titleTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 32),
            child: Text('Единицы измерения', style: Theme.of(context).textTheme.headline3,),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 10
                ),
                BoxShadow(
                  color: Theme.of(context).cardColor,
                  offset: Offset(0, -4),
                  blurRadius: 4
                )
              ]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 20, 0, 16),
                      width: 91,
                      child: Text('Температура', style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  Container(
                    height: 45,
                    padding: EdgeInsets.fromLTRB(107, 13, 20, 13),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: Offset(4, 4),
                                blurRadius: 6,
                                spreadRadius: 0
                            ),
                            BoxShadow(
                              color: Theme.of(context).cardColor,
                              offset: Offset(-2, -3),
                              blurRadius: 3,
                              spreadRadius: 0,
                            )
                          ]
                      ),
                      child: ToggleSwitch(
                          initialLabelIndex: temp,
                          totalSwitches: 2,
                          labels: ['˚C', '˚F'],
                          onToggle: (index) {
                            temp = index;
                            setTemp();
                            initValues();
                          print('switched to: $index');
                        },
                        minHeight: 25,
                        activeBgColor: [Theme.of(context).colorScheme.error],
                        activeFgColor: Theme.of(context).textTheme.headline4!.color,
                        inactiveBgColor: Theme.of(context).colorScheme.background,
                        inactiveFgColor: Theme.of(context).textTheme.headline2!.color ,
                        cornerRadius: 30,
                        fontSize: 12,
                      ),
                    ),
                  )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: CustomPaint(
                    painter: MyPainter(Theme.of(context).shadowColor),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 20, 0, 16),
                      width: 91,
                      child: Text('Сила ветра', style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.fromLTRB(107, 13, 20, 13),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  offset: Offset(4, 4),
                                  blurRadius: 6,
                                  spreadRadius: 0
                              ),
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                offset: Offset(-2, -3),
                                blurRadius: 3,
                                spreadRadius: 0,
                              )
                            ]
                        ),
                        child: ToggleSwitch(
                          initialLabelIndex: speed,
                          totalSwitches: 2,
                          labels: ['м/с', 'км/ч'],
                          onToggle: (index) {
                            speed = index;
                            setSpeed();
                            initValues();
                            print('switched to: $index');
                          },
                          minHeight: 25,
                          activeBgColor: [Theme.of(context).colorScheme.error],
                          activeFgColor: Theme.of(context).textTheme.headline4!.color,
                          inactiveBgColor: Theme.of(context).colorScheme.background,
                          inactiveFgColor: Theme.of(context).textTheme.headline2!.color ,
                          cornerRadius: 30,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: CustomPaint(
                    painter: MyPainter(Theme.of(context).shadowColor),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 20, 0, 16),
                      width: 91,
                      child: Text('Давление', style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.fromLTRB(107, 13, 20, 13),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  offset: Offset(4, 4),
                                  blurRadius: 6,
                                  spreadRadius: 0
                              ),
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                offset: Offset(-2, -3),
                                blurRadius: 3,
                                spreadRadius: 0,
                              )
                            ]
                        ),
                        child: ToggleSwitch(
                          initialLabelIndex: pressure,
                          totalSwitches: 2,
                          labels: ['мм.рт.ст.', 'гПа'],
                          onToggle: (index) {
                            setState(() {
                              pressure = index;
                              setPressure();
                            });
                            print('switched to: $index');
                          },
                          minHeight: 25,
                          activeBgColor: [Theme.of(context).colorScheme.error],
                          activeFgColor: Theme.of(context).textTheme.headline4!.color,
                          inactiveBgColor: Theme.of(context).colorScheme.background,
                          inactiveFgColor: Theme.of(context).textTheme.headline2!.color ,
                          cornerRadius: 30,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: CustomPaint(
                    painter: MyPainter(Theme.of(context).shadowColor),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 20, 0, 16),
                      width: 91,
                      child: Text('Тема', style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.fromLTRB(107, 13, 20, 13),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  offset: Offset(4, 4),
                                  blurRadius: 6,
                                  spreadRadius: 0
                              ),
                              BoxShadow(
                                color: Theme.of(context).cardColor,
                                offset: Offset(-2, -3),
                                blurRadius: 3,
                                spreadRadius: 0,
                              )
                            ]
                        ),
                        child: ToggleSwitch(
                          initialLabelIndex: theme,
                          totalSwitches: 2,
                          labels: ['Dark', 'Light'],
                          onToggle: (index) {
                            setState(() {
                              theme = index;
                              setTheme();
                              currentTheme.toggleTheme();
                            });

                          },
                          minHeight: 25,
                          activeBgColor: [Theme.of(context).colorScheme.error],
                          activeFgColor: Theme.of(context).textTheme.headline4!.color,
                          inactiveBgColor: Theme.of(context).colorScheme.background,
                          inactiveFgColor: Theme.of(context).textTheme.headline2!.color ,
                          cornerRadius: 30,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  int returnInitial(Brightness brightness) {
    if(brightness == Brightness.dark){
      return 0;
    }
    return 1;
  }

  void setTemp() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('temp', temp);
  }

  void setSpeed() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('speed', speed);
  }

  void setPressure() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('pressure', pressure);
  }

  void setTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('theme', theme);
  }

  Future<void> initValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      temp = preferences.getInt('temp')?? 0;
      pressure = preferences.getInt('pressure')?? 0;
      speed = preferences.getInt('speed')?? 0;
      theme = preferences.getInt('theme')?? 0;
    });
  }
}

class MyPainter extends CustomPainter {
  Color color = Colors.white;


  MyPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(20, 0);
    final p2 = Offset(360, 0);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}
