import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/widgets/sidemenu.dart';
import 'package:firebase_database/firebase_database.dart';

class OrdersScreenState extends StatefulWidget{
  @override
  State<OrdersScreenState> createState() =>OrdersScreen();
}

Future GetFlights(var reference) async{
  print("getting value");
  var orders;
  var result=await reference.child("orders").get();
  orders=result.value;
  print(orders);
  return orders;
}

class OrdersScreen extends State<OrdersScreenState>{
  final fb=FirebaseDatabase.instance;
  @override
  Widget build(context){
    final ref=fb.reference();
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Container(
              width: MediaQuery.of(context).size.width * 0.88,
              child:Center(
                child: FutureBuilder(
                  future:GetFlights(ref),
                  builder: (context,snapshot){
                    if(snapshot.data!=null){
                      return Container(
                        height: MediaQuery.of(context).size.height * 1,
                        child: Scrollbar(
                            child:GridView(
                                  padding: EdgeInsets.all(50),
                                  gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10
                                ),
                                  children: [
                                    for(var order in snapshot.data as List)
                                      Card(
                                        child:Center(
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children:[
                                            Expanded(child:SizedBox()),
                                            Text(order[0],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 10),
                                            Text(order[1],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 10,),
                                            Text(order[2].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 10,),
                                            Text(order[4][0]+" to "+order[4][1],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),softWrap: true,textAlign: TextAlign.center,),
                                            SizedBox(height: 10,),
                                            Text(order[5],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue),softWrap: true,textAlign: TextAlign.center,),
                                            SizedBox(height: 12,),
                                            Text("₹ "+order[3].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.green),),
                                            Expanded(child:SizedBox()),
                                          ]
                                        ),
                                      ))

                                  ],
                                )
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              )
          )
        ],
      ),
    );
  }
}