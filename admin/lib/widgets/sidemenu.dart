import 'dart:html';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/screens/allflights.dart';
import 'package:mini_project/utils/items.dart';


var width;
var screen;

class SideMenu extends StatelessWidget{
  GlobalKey _width = GlobalKey();
  @override
  Widget build(context){
    screen=ModalRoute.of(context)!.settings.name;
    print(ModalRoute.of(context)!.settings.name);
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      child:Container(
          key: _width,
          color: Colors.black,
          child: Padding(
              padding:EdgeInsets.fromLTRB(0, 30, 0, 30),
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    for(var item in SideMenuMainItems)
                      (item=="Flights"&&(screen=="/AllFlights"||screen=="/NewFlight"))?Column(children: [buildsubmenumainitems(item,context),builtselectedcontainer(context)],):buildsubmenumainitems(item,context),

                  ]
              )
          )
      )
    );
  }

  Widget buildsubmenumainitems(var item,context){
    return MouseRegion(
      onExit:(event){
        print("exited");
      },

      onEnter: (event) async{
        print(screen);
        if(item=="Flights"&&(screen!="/AllFlights"&&screen!="/NewFlight")){
           var selected= await showMenu(
                color: Color(0xff2C3338),
                context: context,
                position:RelativeRect.fromSize(Rect.fromLTRB(MediaQuery.of(context).size.width * 0.12, 70, 0, 0), Size.infinite),
                items: [
                  for(var subitems in FlightsSubMenu)
                    PopupMenuItem(
                      value: subitems,
                      textStyle: TextStyle(color: Colors.white),
                      child: Text(subitems),
                    ),
                ],
              );
           if(selected=="All Flights"){
             Navigator.pushNamed(
               context,
               '/AllFlights',
             );
           };
           if(selected=="Add New"){
             Navigator.pushNamed(
               context,
               '/NewFlight',
             );
           };
        }
      },
      child: InkWell(
        onTap: (){
          if(item=="Dashboard"){
            Navigator.pushNamed(
              context,
              '/',
            );
          };
          if(item=="Bookings"){
            Navigator.pushNamed(
              context,
              '/Bookings',
            );
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Row(
            children: [
              if(item=="Flights")
                Icon(Icons.flight,color: Colors.white,size: 22,),
              if(item=="Dashboard")
                Icon(Icons.dashboard,color: Colors.white,size: 22,),
              if(item=="Bookings")
                Icon(Icons.perm_contact_calendar ,color: Colors.white,size: 22,),
              SizedBox(width:5),
              Text(item,style:TextStyle(color: Colors.white,fontSize: 17))
            ],
          ),
        ),
      )
    );
  }

  builtselectedcontainer(context){
    return Container(
      width:MediaQuery.of(context).size.width * 0.12,
      color: Color(0xff2C3338),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var item in FlightsSubMenu)
              InkWell(
                onTap: (){
                  if(item=="All Flights"){
                    Navigator.pushNamed(
                      context,
                      '/AllFlights',
                    );
                  }
                  if(item=="Add New"){
                    Navigator.pushNamed(
                      context,
                      '/NewFlight',
                    );
                  }

                },
                child:Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ((screen=="/AllFlights"&&item=="All Flights")||screen=="/NewFlight"&&item=="Add New")?Text(item,style:TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)):Text(item,style:TextStyle(color: Colors.grey,fontSize: 17)),
                )
              )
        ],
      )
    );
  }

}