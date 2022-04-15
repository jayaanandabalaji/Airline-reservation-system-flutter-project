import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class BookingSuccessState extends StatefulWidget{
  final name;
  final email;
  final phone;
  final cost;
  final fromto;
  final time;
  BookingSuccessState(this.name, this.email, this.phone, this.cost, this.fromto, this.time);
  @override
  State<BookingSuccessState> createState()=>BookingSuccessScreen(name,email,phone,cost,fromto,time);
}

var variable=["567"];

Future AddOrder(reference,name,email,phone,cost,fromto,time) async{
  var result=await reference.child("orders").get();
  var builtorderdata=[];
  builtorderdata.add(name);
  builtorderdata.add(email);
  builtorderdata.add(phone);
  builtorderdata.add(cost);
  builtorderdata.add(fromto);
  builtorderdata.add(time);
  var currentorderdata=[];
  print(result.value);
  if(result.value!=null){
    currentorderdata=result.value;
    print(currentorderdata);
  }
  currentorderdata.insert(0,builtorderdata);
  await reference.child("orders").set(currentorderdata);
  return true;
}

class BookingSuccessScreen extends State<BookingSuccessState>{
  final fb=FirebaseDatabase.instance;
  final name;
  final email;
  final phone;
  final cost;
  final fromto;
  final time;
  BookingSuccessScreen(this.name, this.email, this.phone, this.cost, this.fromto, this.time);
  @override
  Widget build(BuildContext context) {
    final ref=fb.reference();
    return Scaffold(
      body:Center(
        child: FutureBuilder(
          future:AddOrder(ref,name,email,phone,cost,fromto,time),
          builder: (context,snapshot){
            if(snapshot.data!=null){
              return Text("Congrats Your order has been successfully noted. Please check your mail for further info!!!",style:TextStyle(fontSize:20));
            }
            return CircularProgressIndicator();
          },
        )
      )
    );
  }
}