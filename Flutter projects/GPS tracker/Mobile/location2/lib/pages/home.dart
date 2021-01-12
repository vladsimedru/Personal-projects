import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool automaticallySendLocation=false;
  Timer timer;

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

     LocationData locationData = await location.getLocation();

    print("$locationData");

    print('${locationData.latitude}');
    print('${locationData.longitude}');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${prefs.getString('email')}');
    print('${prefs.getString('password')}');

    await sendLocation(locationData);
  }

  Future<void> sendLocation(LocationData locationData) async {
     print('${locationData.latitude}');
     print('${locationData.longitude}');

     SharedPreferences prefs = await SharedPreferences.getInstance();
     print('${prefs.getString('email')}');
     print('${prefs.getString('password')}');

     String url = 'http://192.168.0.108:8080/locations';
     String basicAuth =
         'Basic ' + base64Encode(utf8.encode('${prefs.getString('email')}:${prefs.getString('password')}'));
     Map<String, String> headers = {
       'accept':'application/json',
       'content-type': 'application/json',
       'authorization': basicAuth
     };
     String json = '{"longitude": "${locationData.longitude}", "latitude": "${locationData.latitude}","email":"${prefs.getString('email')}"}';

     http.Response response = await http.post(url, headers:headers, body:json);

     print('${response.statusCode}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Home",
          style: TextStyle(
              letterSpacing: 1
          ),
        ),
        actions: <Widget>[
           Padding(
              padding: EdgeInsets.only(right: 20.0),
               child: GestureDetector(
               onTap: () {},
                child: Icon(
                    Icons.more_vert
                ),
              )
           )
        ],
      ),
      body: Padding(
        
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                getLocation();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(143,148,251,1),
                          Color.fromRGBO(143,148,251,.6),
                        ]
                    )
                ),
                child: Center(
                  child: Text(
                    "Send Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(height:30),
            InkWell(
              onTap: () async {
                setState(() {
                  automaticallySendLocation=true;
                });
                Timer.periodic(const Duration(seconds: 1), (timer) {
                  if(!automaticallySendLocation) {
                    timer.cancel();
                  }
                  else {
                    getLocation();
                  }
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(143,148,251,1),
                          Color.fromRGBO(143,148,251,.6),
                        ]
                    )
                ),
                child: Center(
                  child: Text(
                    "Automatically Send Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(height:30),
            InkWell(
              onTap: () {
                setState(() {
                  automaticallySendLocation=false;
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(143,148,251,1),
                          Color.fromRGBO(143,148,251,.6),
                        ]
                    )
                ),
                child: Center(
                  child: Text(
                    "Stop",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(height:30)
          ],
        ),
      )
    );
  }
}