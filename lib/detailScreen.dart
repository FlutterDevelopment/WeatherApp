import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class Detailscreen extends StatefulWidget {
  String cityname;
  Detailscreen({super.key,required this.cityname});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  Weather? w;
  WeatherFactory wf = WeatherFactory("62bc2c6655edd8bff0883c4fc16b002e");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body:FutureBuilder(
        future: wf.currentWeatherByCityName(widget.cityname),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            w=snapshot.data;
            return w==null? Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1),
                    Text('Currently in',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                    Text('${w?.areaName}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1),
                    Center(
                      child: Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                          Icon(Icons.thermostat,color: Colors.black,),
                          Text('${w?.temperature?.celsius?.toStringAsFixed(2)}ºC'),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                          Image.network('http://openweathermap.org/img/w/${w?.weatherIcon}.png',),
                          Text(w?.weatherMain??"null"),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thermostat,color: Colors.black,),
                                SizedBox(width:  100,),
                                Text("Tempertaure"),
                                SizedBox(width:80,),
                                Text('${w?.temperature?.celsius?.toStringAsFixed(2)}ºC')
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                            Row(
                              children: [
                                Icon(Icons.sunny,color: Colors.black,),
                                SizedBox(width:  110,),
                                Text("Humidity"),
                                SizedBox(width: 100),
                                Text('${w?.humidity.toString()}%'),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                            Row(
                              children: [
                                Icon(Icons.wind_power,color: Colors.black,),
                                SizedBox(width:  110,),
                                Text("WindSpeed "),
                                SizedBox(width: 100,),
                                Text(w?.windSpeed.toString()??"null"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white54,
                          shape: BoxShape.rectangle
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.hasError){
            if(snapshot.error.toString().contains('404')){
               return Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset("images/asset/sademoji.png"),
                   Text("Sorry! City Not Found",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                   Text("Please Check Spelling You've Entered!!",style: TextStyle(fontSize: 10,color: Colors.black),)
                 ],
               ),
               );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Detailscreen(cityname:widget.cityname)));
      },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: Colors.blue,
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

