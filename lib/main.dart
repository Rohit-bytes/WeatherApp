
import 'package:flutter/material.dart';
import 'package:weather_app/Weather_Screen.dart';

void main(){
 runApp(const WeatherApp());
}


class WeatherApp extends StatelessWidget
{
  const WeatherApp ({super.key});
  @override
  Widget  build(BuildContext context)
  {

    return MaterialApp(
    debugShowCheckedModeBanner: false,
   theme:ThemeData.light(useMaterial3: true,),
   title: "Weather App",
   home: const WeatherScreen() ,
    );
 }  

 }