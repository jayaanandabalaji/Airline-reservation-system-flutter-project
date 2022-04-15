import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_user/screens/BookFlight.dart';

class HomeState extends StatefulWidget{
  State<HomeState> createState() =>HomeScreen();
}

Future GetFlights(var reference) async{
  print("getting value");
  var flights;
  var result=await reference.child("Flights").get();
  flights=result.value;
  print(flights);
  return flights;
}

class HomeScreen extends State<HomeState>{
  final fb=FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final ref=fb.reference();
    return Scaffold(
        appBar:AppBar(title:Text("All Flights")),
      body:Center(
        child:(MediaQuery.of(context).size.width>800)?FutureBuilder(
            future: GetFlights(ref),
            builder: (context,snapshot){
              if(snapshot.data!=null){
                List Flights=snapshot.data as List;
                return  Scrollbar(child:ListView(
                  padding:EdgeInsets.all(50),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: Flights.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child:Card(
                                child:Padding(
                                    padding: EdgeInsets.all(25),
                                    child:Row(
                                      children: [
                                        Expanded(
                                            child:Row(
                                              children: [
                                                Icon(Icons.flight),
                                                SizedBox(width: 10,),
                                                Text(Flights[index]["name"],style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child:Column(
                                              children: [
                                                Text(Flights[index]["data"][0][0],style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                SizedBox(height:5),
                                                Text("${Flights[index]["data"][0][1].split(" ")[1]}${Flights[index]["data"][0][1].split(" ")[2]}",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                                              ],
                                          )
                                        ),
                                        Expanded(
                                            child:Column(
                                              children: [
                                                Text(Flights[index]["data"][Flights[index]["data"].length-1][0],style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                SizedBox(height:5),
                                                Text("${Flights[index]["data"][Flights[index]["data"].length-1][1].split(" ")[1]} ${Flights[index]["data"][0][1].split(" ")[2]}",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500),)
                                              ],
                                            )
                                        ),
                                        Expanded(
                                          child:Container(
                                            decoration:BoxDecoration(
                                              border:Border.all(color: (int.parse(Flights[index]["seats"])>100)?Colors.green:(int.parse(Flights[index]["seats"])<=100&&int.parse(Flights[index]["seats"])>20)?Colors.orange:Colors.red,width:2),
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                            child:Padding(padding:EdgeInsets.only(left:10),child:Text(Flights[index]["seats"]+" seats available",style:TextStyle(color: Colors.black,fontSize:18)))
                                          )
                                        ),
                                        Expanded(
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text("₹ "+Flights[index]["data"][Flights[index]["data"].length-1][2],style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                                              ],
                                            ),
                                        ),
                                        Expanded(
                                              child:Align(
                                                  alignment:Alignment.topRight,
                                                  child:ElevatedButton(onPressed: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => BookFlightState(Flights[index])),
                                                    );
                                                  }, child: Text("Book Now"))
                                              )
                                        )
                                      ],
                                    )
                                )
                            )
                          );
                        },
                      )
                    ],
                ));
              }
              return CircularProgressIndicator();
            }
        ):Padding(padding:EdgeInsets.all(10),child:Text("To preserve the responsiveness, this website is prevented from opening on mobile. Please, check this website on desktop!!!",style:TextStyle(fontSize:20)))
      )
    );
  }
}