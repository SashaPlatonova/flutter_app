import 'package:flutter/material.dart';
import 'package:flutter_app/week_weather.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 235, 255, 1.0),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: (
                    ){
                  Navigator.pop(context);
                 },
                child: Icon(Icons.arrow_back_ios),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(226, 235, 255, 1.0),
                  onPrimary: Color.fromRGBO(50, 50, 50, 1.0),
                shape: CircleBorder(),
                elevation: 0
              )
            ),
            Container(
              height: 50,
              width: 250,
            child:
              TextField(
                decoration: InputDecoration(
                  hintText: 'Введите название города...',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(130, 130, 130, 1.0),
                      fontSize: 15)
                ),
                showCursor: true,
                cursorColor: Colors.black,
                style: TextStyle(
                  color: Color.fromRGBO(50, 50, 50, 1.0),
                  fontSize: 13
                ),
                onSubmitted: (text){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeekWeather()));
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
                },
                child: Icon(Icons.cancel),

            )
          ],
        ),
      )
    );
  }
}