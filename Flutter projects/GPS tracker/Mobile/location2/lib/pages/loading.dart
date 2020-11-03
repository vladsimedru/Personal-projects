import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Text('loading'),
      )
    );
  }

  Future<AlertDialog> login(String email,String password) async{
    String url = 'http://192.168.0.107:8080/users/login';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$email:$password'));
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept':'application/json',
      'authorization': basicAuth
    };
    String json = '{"email": "$email", "password": "$password"}';

    http.Response response = await http.post(url, headers:headers, body:json);

    if (response.statusCode==200)
      Navigator.pushReplacementNamed(context, '/home');
  }
}
