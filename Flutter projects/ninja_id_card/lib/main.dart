import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
home:NinjaCardId(),
));

class NinjaCardId extends StatefulWidget{
  @override
  _NinjaCardIdState createState() => _NinjaCardIdState();
}

class _NinjaCardIdState extends State<NinjaCardId> {
  int ninjaLevel=0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('ID Card'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        elevation: 0,
      ),
      body:Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage:AssetImage('assets/picture_1.jpg'),
                radius:60,
              ),
            ),
            Divider(
              height: 60,
             color: Colors.grey[600],
            ),
            SizedBox(height: 30),
            Text(
              'Name',
              style:TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey,
                fontSize:14,
              )
            ),
            Text(
                'Vlad Simedru',
                style:TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.amberAccent,
                  fontSize:18,
                )
            ),
            SizedBox(height:30),
            Text(
                'Job wanted',
                style:TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey,
                  fontSize:14,
                )
            ),
            Text(
                'Mobile developer',
                style:TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.amberAccent,
                  fontSize:18,
                )
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  'simedruvlad@yahoo.com',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    color:Colors.amberAccent,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(
                Icons.phone_android,
                  color:Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  '0743 620 039',
                  style:TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 18,
                    letterSpacing: 1,
                  )
                )
              ],
            ),
            SizedBox(height: 30),
            Text(
              'About me',
              style:TextStyle(
                color:Colors.grey,
                fontSize: 14,
                letterSpacing: 2,
              )
            ),
            Text(
              'In the 4th year of study. '
              'Passionate about developing mobile applications.'
                  ' Fast learner and easily adaptable.',
                  style:TextStyle(
                    color: Colors.amberAccent,
                    letterSpacing: 1,
                  )
            )
          ],
        ),
      )
    );
  }
}