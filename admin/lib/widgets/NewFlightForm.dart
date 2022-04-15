import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

List<List> Reordarablelist=[["From",0],["To",1]];
var DatesList={};
var TimeList={};
double boxheight=1000.00;

class NewFLightForm extends StatelessWidget{
  final fb=FirebaseDatabase.instance;
  final ValueNotifier<bool> isbuttonloading=ValueNotifier(false);
  final TextEditingController Airplanename=TextEditingController();
  var DateControllersList=<TextEditingController>[TextEditingController(),TextEditingController()];
  var LocationControllersList=<TextEditingController>[TextEditingController(),TextEditingController()];
  var PriceControllerslist=<TextEditingController>[TextEditingController(),TextEditingController()];
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  NewFLightForm();
  var Numberofseats=new TextEditingController();

  @override
  Widget build(context){
    final ref=fb.reference();
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      child: Scrollbar(
          isAlwaysShown: true, // <---- Required
          child:StatefulBuilder(
            builder: (context2,setter) {
              return Form(
                key:_formkey,
                  child:ListView(
                padding: EdgeInsets.all(100),
                children: [
                  Text("Add new Airplane",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(height: 40,),
                  Container(
                      width:50,
                      child:TextFormField(
                        controller:Airplanename,
                          decoration:const InputDecoration(
                              labelText: 'Airplane Name'
                          ),
                          validator: (value){
                            if(value==""){
                              return "This field is required";
                            }
                          }
                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add), onPressed: () {
                          Reordarablelist[Reordarablelist.length-1][1]=Reordarablelist[Reordarablelist.length-1][1]+1;
                          Reordarablelist.insert(Reordarablelist.length-1,["Mid Stops",Reordarablelist.length-1]);
                          DateControllersList.insert(DateControllersList.length-1,TextEditingController());
                          LocationControllersList.insert(LocationControllersList.length-1,TextEditingController());
                          PriceControllerslist.insert(PriceControllerslist.length-1,TextEditingController());
                          setter(() {});
                        },
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      decoration:BoxDecoration(
                        border: Border.all(color:Colors.grey,width: 1,style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      child: ReorderableListView.builder(
                        shrinkWrap:true,
                        itemCount:Reordarablelist.length,
                        itemBuilder: (context,index){
                          return Container(
                              padding:EdgeInsets.all(20),
                              key: ValueKey(Reordarablelist[index][1]),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children:[
                                      Container(
                                        width: 100,
                                        child: TextFormField(
                                          validator: (value){
                                            if(value==""){
                                              return "This field is required";
                                            }
                                          },
                                          controller: LocationControllersList[index],
                                          decoration: InputDecoration(labelText: Reordarablelist[index][0]),
                                        ),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        width: 250,
                                        child:TextFormField(
                                          validator: (value){
                                            if(value==""){
                                              return "This field is required";
                                            }
                                          },
                                          controller: DateControllersList[index],
                                          onTap: () async {
                                            DatesList[index.toString()]=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2022));
                                            if(DatesList[index.toString()]!=null){
                                              TimeList[index.toString()]=await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                            }
                                            if(TimeList[index.toString()]!=null){
                                              DateControllersList[index].text=DateFormat.yMd().format(DatesList[index.toString()]).toString()+" "+TimeList[index.toString()].format(context);
                                            }
                                          },
                                          decoration: InputDecoration(hintText: 'Time of arrival'),
                                        ),
                                      ),
                                      SizedBox(width: 30,),
                                      if(index!=0)
                                        Container(
                                          width: 100,
                                          child: TextFormField(
                                            validator: (value){
                                              if(value==""){
                                                return "This field is required";
                                              }
                                            },
                                            controller:PriceControllerslist[index],
                                            decoration: InputDecoration(hintText: "Cost in ₹"),
                                          ),
                                        )
                                    ],
                                  ),
                                  if(index!=0&&index!=Reordarablelist.length-1)
                                  Container(
                                    padding:EdgeInsets.fromLTRB(0,0,30,0),
                                    child:IconButton(
                                      onPressed: (){
                                        DateControllersList.removeAt(index);
                                        LocationControllersList.removeAt(index);
                                        PriceControllerslist.removeAt(index);
                                        Reordarablelist.removeAt(index);
                                        setter((){});
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  )
                                ],
                              )
                          );
                        },

                        onReorder: (int oldIndex, int newIndex) {
                          setter(() {
                            if(newIndex>oldIndex){
                              newIndex-=1;
                            }

                            var tempDateController=DateControllersList.removeAt(oldIndex);
                            DateControllersList.insert(newIndex, tempDateController);

                            var tempLocationController=LocationControllersList.removeAt(oldIndex);
                            LocationControllersList.insert(newIndex, tempLocationController);

                            var tempPriceController=PriceControllerslist.removeAt(oldIndex);
                            PriceControllerslist.insert(newIndex, tempPriceController);

                          }
                          );

                        },


                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width:200,
                    child:TextFormField(
                      controller:Numberofseats,
                      decoration: InputDecoration(
                        labelText:"Total Number of seats available"
                      ),
                      validator:(value){
                        if(value==""){
                          return "This field is required";
                        }
                      }
                    )
                  ),
                  SizedBox(height: 20,),

                  ElevatedButton(onPressed: ()async{
                    if(_formkey.currentState!.validate()){
                      isbuttonloading.value=true;
                      var jsondata={};
                      jsondata["name"]=Airplanename.text;
                      jsondata["data"]=[];
                      for(var index=0;LocationControllersList.length>index;index++){
                        var tempjson=[];
                        tempjson.add(LocationControllersList[index].text);
                        tempjson.add(DateControllersList[index].text);
                        tempjson.add(PriceControllerslist[index].text.toString());
                        jsondata["data"].add(tempjson);
                      }
                      jsondata["seats"]=Numberofseats.text;
                      var CurrentFLights;
                      await ref.child("Flights").get().then((result){
                        CurrentFLights=result.value;
                      }
                      );
                      var finallist=[];
                      if(CurrentFLights==null){
                        finallist.add(jsondata);
                        await ref.child("Flights").set(finallist);
                      }
                      else{
                        finallist=CurrentFLights as List;
                        finallist.insert(0,jsondata);
                        await ref.child("Flights").set(finallist);
                      }
                      showDialog(builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success"),
                          content:Text("Flight added successfull!!!")

                        );
                      }, context: context
                      );
                      setter((){
                        Airplanename.text="";
                        DateControllersList=[new TextEditingController(),new TextEditingController()];
                        LocationControllersList=[new TextEditingController(),new TextEditingController()];
                        PriceControllerslist=[new TextEditingController(),new TextEditingController()];
                        Numberofseats=new TextEditingController();
                      });
                      isbuttonloading.value=false;

                    }

                  },
                      child: Container(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),child:ValueListenableBuilder(
                        valueListenable: isbuttonloading,
                        builder:(context,value,_){
                          if(value==false){
                            return Text("Add",style:TextStyle(fontSize:20));
                          }
                          else{
                            return CircularProgressIndicator(color:Colors.white);
                          }
                        }

                      ))),
                ],
              ));
            },
          )
      )
    );
  }


}