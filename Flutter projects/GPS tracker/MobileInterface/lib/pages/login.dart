import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  }

class _LoginState extends State<Login> {

  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<Response> sendData(String email,String password) async {
   String url = 'http://192.168.0.107:8080/users/login';
   String basicAuth =
       'Basic ' + base64Encode(utf8.encode('$email:$password'));
   Map<String, String> headers = {
     'accept':'application/json',
     'content-type': 'application/json',
     'authorization': basicAuth
   };
   String json = '{"email": "$email", "password": "$password"}';

   http.Response response = await http.post(url, headers:headers, body:json);

   return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Login",
          style: TextStyle(
            letterSpacing: 1
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
           mainAxisAlignment:MainAxisAlignment.center,
          children:<Widget>[
              Padding(
                  padding:EdgeInsets.all(20),
                  child:Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:
                          [
                            BoxShadow(
                            color: Color.fromRGBO(143,148,251,.2),
                            blurRadius: 20.0,
                            offset: Offset(0,10)
                            ),
                          ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:Colors.grey[100]
                                )
                              )
                              ),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                hintText:"Email",
                                  border:InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:Colors.grey[100]
                                      )
                                  )
                              ),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                autocorrect: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    hintText:"Password",
                                    border:InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          http.Response response = await sendData(emailController.text,passwordController.text);
                          if (response.statusCode==200)
                            Navigator.of(context).pushReplacementNamed('/home');
                          else
                            print(response.statusCode);
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
                                  "Login",
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
                      Row(
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color:  Color.fromRGBO(143,148,251,1),
                              ),
                            ),
                            onTap:() {print("Hello");},
                          ),
                          Spacer(),
                          InkWell(
                            child: Text(
                              "New user? Sign up",
                              style: TextStyle(
                                color:  Color.fromRGBO(143,148,251,1),
                              ),
                            ),
                            onTap:() {
                              Navigator.of(context).pushNamed('/register');
                              },
                          ),
                        ],
                      )
                    ],
                  )
              )
            ]
        ),
    );
  }
}