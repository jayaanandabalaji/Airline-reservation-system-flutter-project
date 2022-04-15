import 'package:flutter/material.dart';
import 'package:mini_project_user/screens/BookFlight.dart';
import 'package:mini_project_user/screens/Success.dart';
import 'package:mini_project_user/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:'/',
      routes: {
        '/':(context)=>HomeState(),
        '/bookflight':(context)=>BookFlightState(null),
        '/success':(context)=>BookingSuccessState(null,null,null,null,null,null)
      },
    );
  }
}
