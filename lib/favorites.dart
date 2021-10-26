import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

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
            onPressed: () {
              Navigator.pop(context);
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
            child: getFavCity(["Москва", "СПб"], Theme
                .of(context)
                .colorScheme
                .brightness)
          ),
        )
    );
  }

  ListView getFavCity(List<String> city, Brightness brightness) {
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
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 206),
                        child: Text(city[index], style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),),
                      ),
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
                              onPressed: () {},
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
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(city[index], style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),),
                    ),
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
                              city.removeAt(index);
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