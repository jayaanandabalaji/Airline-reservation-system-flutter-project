import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_user/screens/Success.dart';

class BookFlightState extends StatefulWidget{
  final flightdetails;
  BookFlightState(this.flightdetails);
  @override
  State<BookFlightState> createState() {
    return BookFLightScreen(flightdetails);
  }

}

class BookFLightScreen extends State<BookFlightState>{
  final flightdetails;
  BookFLightScreen(this.flightdetails);
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController TicketsCount=new TextEditingController();
  TextEditingController name=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  var ticketscount=1;
  @override
  Widget build(context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Flight Booking")
      ),
      body:Padding(
        padding:EdgeInsets.fromLTRB(100,100,100,0),
        child:Form(
          key:_formKey,
          child: ListView(
            shrinkWrap:true,
            children: [
              Row(
                children: [
                  Container(
                    width: 300,
                    child:TextFormField(
                      enabled: false,
                      decoration:InputDecoration(
                        labelText: flightdetails["data"][0][0],
                        labelStyle: TextStyle(color: Colors.black,fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Icon(Icons.arrow_forward),
                  SizedBox(width:30),
                  Container(
                    width:300,
                    child:TextFormField(
                      enabled: false,
                      decoration:InputDecoration(
                        labelText: flightdetails["data"][flightdetails["data"].length-1][0],
                        labelStyle: TextStyle(color: Colors.black,fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Text("( ${flightdetails["data"][0][1]} - ${flightdetails["data"][flightdetails["data"].length-1][1]} )",style:TextStyle(fontSize:20))
                ],
              ),
              SizedBox(height:40),
              Row(
                children:[
                  Container(
                    width:300,
                    child:TextFormField(
                      controller:name,
                      decoration:InputDecoration(
                        labelText: "Your Name"
                      ),
                      validator:(value){
                       
                        if(value==""){
                          return "This field is required";
                        }
                      }
                    )
                  ),
                  SizedBox(width:30),
                  Container(
                      width:300,
                      child:TextFormField(
                          controller:email,
                          decoration:InputDecoration(
                              labelText: "Email address"
                          ),
                        validator:(value){
                            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){
                              return "Please enter a valid email address";
                            }
                        }
                      )
                  ),
                  SizedBox(width:30),
                  Container(
                      width:300,
                      child:TextFormField(
                          controller:phone,
                          decoration:InputDecoration(
                              labelText: "Phone Number"
                          ),
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        validator:(value){
                            if(value==""){
                             return "Please enter a valid phone number";
                            }
                        }
                      )
                  )
                ]
              ),
              SizedBox(height:40),
              Row(
                children:[
                  Container(
                    width:100,
                    child:TextFormField(
                      maxLength: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      controller:TicketsCount,
                      decoration:InputDecoration(
                          labelText: "TicketsCount"
                      ),
                      validator:(value){
                        if(value==""){
                          return "This field is required";
                        }
                      },
                      onChanged: (value){
                        if(value!=""){
                          setState((){
                            ticketscount=int.parse(value);
                          });
                        }
                      },
                    ),
                  ),
                ]
              ),
              SizedBox(height:50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Total : ",style:TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                  SizedBox(width:20),
                  Text("₹ ${ticketscount*int.parse(flightdetails["data"][flightdetails["data"].length-1][2])}",style:TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                  SizedBox(width:20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed:(){
                      if(_formKey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingSuccessState(name.text,email.text,phone.text,ticketscount*int.parse(flightdetails["data"][flightdetails["data"].length-1][2]),[flightdetails["data"][0][0],flightdetails["data"][flightdetails["data"].length-1][0]],"${flightdetails["data"][0][1].split(" ")[1]}${flightdetails["data"][0][1].split(" ")[2]}")),
                        );
                      }
                    },
                        child:Container(
                            padding:EdgeInsets.fromLTRB(50, 5, 50, 5),
                            child:Text("Book Now",style:TextStyle(color:Colors.white,fontSize:25))))
                ],
              )
            ],
          ),
        )
      )
    );
  }
}