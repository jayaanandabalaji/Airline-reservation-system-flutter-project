import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/main.dart';
import 'package:mini_project/widgets/NewFlightForm.dart';
import 'package:mini_project/widgets/sidemenu.dart';

class NewFlightState extends StatefulWidget{
  @override
  State<NewFlightState> createState()=>NewFlightScreen();
}

class NewFlightScreen extends State<NewFlightState>{



  @override
  Widget build(context){
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Container(
            width: MediaQuery.of(context).size.width * 0.88,
            child:NewFLightForm()
          )
        ],
      ),
    );
  }
}