import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool automaticallySendLocation=false;
  Timer timer;

  Future<void> sendLocation() async {
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

    _locationData = await location.getLocation();

    print(_locationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                sendLocation();
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
                Timer.periodic(const Duration(seconds: 180), (timer) {
                  if(!automaticallySendLocation) {
                    timer.cancel();
                  }
                  else {
                    sendLocation();
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