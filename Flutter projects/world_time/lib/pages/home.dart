import 'package:flutter/material.dart';

class Home extends StatefulWidget {



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    print(data['isDaytime']);

    String bgImage= data['isDaytime']? 'day.jpg':'night.jpg';
    Color bgColor=data['isDaytime']?Colors.blue:Colors.indigo[700];
    Color txtColor=data['isDaytime']?Colors.black54:Colors.blueGrey[100];

    return Scaffold(
      backgroundColor: bgColor,
      body:SafeArea(
          child:Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit:BoxFit.cover,
                )
              ),
           child:Padding(
           padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
           child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async{
                  dynamic result= await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data={
                      'time':result['time'],
                      'location':result['location'],
                      'isDaytime':result['isDaytime'],
                      'flag':result['flag']
                    };
                  });
                  },
                icon:Icon(
                    Icons.edit_location,
                    color: txtColor,
                ),
                label: Text(
                    'Edit Location',
                   style: TextStyle(
                     color: txtColor,
                   ),
                    )
                ,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color:txtColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height:20),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66,
                  letterSpacing: 2,
                  color: txtColor,
                ),
              )
            ],
          ),
        )
      )
    )
    );
  }
}
