import 'package:flutter/material.dart';
import 'package:location2/pages/home.dart';
import 'package:location2/pages/loading.dart';
import 'package:location2/pages/login.dart';
import 'package:location2/pages/register.dart';

void main() =>runApp(MaterialApp(
    initialRoute: '/login',
    routes:{
      '/loading':(context)=>Loading(),
      '/home':(context)=>Home(),
      '/login':(context)=> Login(),
      '/register':(context)=>Register()
    }
));