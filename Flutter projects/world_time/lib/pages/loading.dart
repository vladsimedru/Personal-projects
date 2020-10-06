import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async{
    WorldTime instance= new WorldTime(location:'Berlin',flag:'germany.png',url:'Europe/Berlin');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments:{
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime':instance.isDaytime,
    });
  }
  
  @override
  void initState(){
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body:Center(
         child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            SpinKitCubeGrid(
            color: Colors.white,
            size: 80.0,
            ),
            SizedBox(height:20),
            Text(
              'Perfect Time',
              style: TextStyle(
                fontSize: 28,
                letterSpacing: 2,
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
            )
           ]
      ),
        )

    );
  }
}
