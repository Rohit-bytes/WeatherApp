import 'dart:convert';
import "dart:ui";
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Additonal_Information.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';




class WeatherScreen extends StatefulWidget {

 const WeatherScreen ({super.key});
 
 

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

late Future weather;


Future getCurrentWeather() async{

 
 try{ String City="Delhi";
 final res= await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$City&appid=$openwheather"),
  );

  // print(res.body);
  
  final data=jsonDecode(res.body);
if(data['cod']!='200'){
  throw 'An unexpected error occurred';


}


return data;



  
 

 }
 

 catch(e){
print(e);
}


}
  @override
 void initState(){
  super.initState();
 weather=getCurrentWeather();
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Weather App",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
       centerTitle: true,
   
       actions:[ 
        IconButton(onPressed: (){
setState(() {
  weather=getCurrentWeather();
});

        }, icon:const Icon(Icons.refresh_rounded),),
       ],
      
       ),
       drawer:const Drawer(
child: Row(


mainAxisAlignment: MainAxisAlignment.center,
children: [
  
Align

(
   alignment:Alignment.center,
  child: Icon(Icons.emoji_emotions_rounded,size: 20,color: Colors.blue,)),

SizedBox(height: 100,),
Align(
  
  alignment:Alignment.center,
child:   Text("My Second App"),

),

]


),


       ),
       body:
       
     /*temp==0 ? const LinearProgressIndicator() :*/ FutureBuilder(
      future: weather ,
      builder: (context,snapshot) {
        print(snapshot);
        print(snapshot.runtimeType);
        if(snapshot.connectionState==ConnectionState.waiting){
          return const LinearProgressIndicator();
        }
        if(snapshot.hasError){
          return  Text(snapshot.error.toString());
        }
        if(snapshot.hasData){
          print("not null");
        }
        final data=snapshot.data;

        final currenttemp=data['list'][0]['main']['temp'];
        final currentsky=data['list'][0]['weather'][0]['main'];
      final  humidityadd=data['list'][0]['main']['humidity'];
         final pressureadd=data['list'][0]['main']['pressure'];
         final winds = data['list'][0]['wind']['speed'];
        return Padding(
           padding: const  EdgeInsets.only(left: 12.0,right: 12,bottom: 5,top: 5),
           child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //main card
                 SizedBox(
           
            height: 190,
            width: double.infinity,
            child: Card(
            
              elevation:10 ,
              shadowColor:const  Color.fromARGB(255, 0, 0, 0),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                  child:  Column(
                            
                            
                  children: [
                       const SizedBox(height: 20,),
                   Text("$currenttemp K",style:const  TextStyle(fontSize: 25,fontWeight:FontWeight.bold,
                  ),
                  ),
                        const     SizedBox(height: 20,),
                          Icon(
                           currentsky=="Clouds"||currentsky=="Rain" ? Icons.cloud:Icons.sunny,
                           size: 60,color: Colors.blue,),
                            const  SizedBox(height: 10,),
                            Text("$currentsky"),
                  ],
                            ),
                ),
              ),
            ),
                 ),
                 
           
          const  SizedBox(height: 1,),
            
            const Align(
              alignment:Alignment.centerLeft,
              child: Text("Weather Forecast",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
           
   
SizedBox(
  
  height: 90,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 5, // This should be itemCount, not itemCounter
    itemBuilder: (context, index) {
      final hourlyForecast = data['list'][index + 1];
      final hourlySky = data['list'][index + 1]['weather'][0]['main'];
      final time=DateTime.parse(hourlyForecast['dt_txt']);
      return HourlyForecastItem(
        time:DateFormat("j").format(time),
        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
            ? Icons.cloud
            : Icons.sunny,
        value: hourlyForecast['main']['temp'].toString(),
      );
    },
  ),
),
   

           

            const SizedBox(height: 1,),
            const Align(
              alignment:Alignment.centerLeft,
              child: Text("Additional Information",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        
         Padding(
           padding: EdgeInsets.only(top: 1),
           child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
       //Humidity
       
        Additional(icon: Icons.water_drop_rounded,label:"Humidity",value: humidityadd.toString(),),
       Additional(icon: Icons.wind_power,label: "Wind Speed",value: winds.toString(),),
         Additional(icon: Icons.beach_access,label: "Pressure",value: pressureadd.toString(),)
       ],
       ),
         ),
       
           ],),
         );
      },
     ),
    );

  }
}


class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;
  const HourlyForecastItem({super.key,
  required this.time,
  required this.icon,
  required this.value,
  
  });

  @override
  Widget build(BuildContext context) {
    return  
    Card(
   child:  SizedBox(
    height: 90,
    width: 90,
     child: Column(children: [
     const SizedBox(height: 5,),
      Text(time,style: const TextStyle(fontSize: 13,color: Colors.grey),maxLines: 1,overflow:TextOverflow.ellipsis ,),
     const SizedBox(height: 5,),
     
     Icon(icon,size: 30,color: Colors.blue,),
     const SizedBox(height: 5,),
     Text(value,style:  const TextStyle(fontSize: 9,color: Colors.grey,fontWeight: FontWeight.bold),),
     const SizedBox(height: 5,),
      ],),
   ),
   );
   
  }
}