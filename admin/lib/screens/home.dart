import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/widgets/sidemenu.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreenState extends StatefulWidget{
  @override
  State<HomeScreenState> createState() =>HomeScreen();
}

Future<List> GetOrdersandflights(references) async{
  var result=await references.child("Flights").get();
  var returnlist=[];
  if(result.value!=null){
    returnlist.add(result.value.length);
  }
  else{
    returnlist.add(0);
  }

  result=await references.child("orders").get();
  if(result.value!=null){
    returnlist.add(result.value.length);
  }
  else{
    returnlist.add(0);
  }

  return returnlist;
}
class HomeScreen extends State<HomeScreenState>{
  final fb=FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final ref=fb.reference();
    return Scaffold(
      body: (MediaQuery.of(context).size.width>800)?Row(
        children: [
          SideMenu(),
          Container(
            width: MediaQuery.of(context).size.width * 0.88,
            child:Container(
              padding:EdgeInsets.all(50),
              child:Center(
                child:FutureBuilder(
                  future:GetOrdersandflights(ref),
                  builder:(context,snapshot){
                    if(snapshot.data!=null){
                      var value=snapshot.data as List;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 800,
                            height: 100,
                            color:Colors.lightBlueAccent,
                            child: Center(child:Text("Flights scheduled : ${value[0]}",style: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            width: 800,
                            height: 100,
                            color:Colors.lightGreen,
                            child: Center(child:Text("Total Bookings : ${value[1]}",style: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
                          )
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  }
                )
              )
            ),
          )
        ],
      ):Center(child:Padding(padding:EdgeInsets.all(10),child:Text("To preserve the responsiveness, this website is prevented from opening on mobile. Please, check this website on desktop!!!",style:TextStyle(fontSize:20)))),
    );
  }

}
