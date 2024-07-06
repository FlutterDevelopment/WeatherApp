import 'package:flutter/material.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:weatherapp/detailScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchcontroller = TextEditingController();
  bool isloading = false;
  String value="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.sunny_snowing),
        title: Text("Weather"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
            child: InputHistoryTextField(
              historyKey: "01",
              textEditingController: searchcontroller,
              listStyle: ListStyle.List,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.maps_home_work),
                suffixIcon: Icon(Icons.search),
                hintText: "Enter City Name...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 150,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailscreen(cityname: searchcontroller.text)));
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
            child: Text("Search",style:TextStyle(color: Colors.black,fontSize: 18),),
          ),
        ],
      ),
    );
  }
}
