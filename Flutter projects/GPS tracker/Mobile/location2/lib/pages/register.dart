import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstNameController=TextEditingController();
  final lastNameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final passwordConfirmController=TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  Future<Response> register(String firstName,String lastName,String email,String password,String confirmPassword) async {
    String url = 'http://192.168.0.107:8080/users/register';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$email:$password'));
    Map<String, String> headers = {
      'accept':'application/json',
      'content-type': 'application/json',
    };
    String json = '{"firstName": "$firstName","lastName":"$lastName","email": "$email", "password": "$password","confirmPassword":"$confirmPassword"}';

    http.Response response = await http.post(url, headers:headers, body:json);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Register",
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
             Navigator.of(context).pop();
          },
        ),
      ),
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
                              controller: firstNameController,
                              decoration: InputDecoration(
                                hintText:"First Name",
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
                              controller: lastNameController,
                              decoration: InputDecoration(
                                hintText:"Last Name",
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
                                  )
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
                              controller: passwordConfirmController,
                              decoration: InputDecoration(
                                hintText:"Confirm Password",
                                border:InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
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
                        http.Response response = await register(firstNameController.text,lastNameController.text,emailController.text,passwordController.text,passwordConfirmController.text);
                        if (response.statusCode==200) {
                          Navigator.of(context).pop();
                          Toast.show("Successful sign up!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        }
                        else{
                          Toast.show("${response.body}", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }},
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
                            "Register",
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
                  ],
                )
            )
          ]
      ),
    );
  }
}