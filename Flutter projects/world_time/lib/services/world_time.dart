import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;
  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{
    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //set the time property
      isDaytime=now.hour>6 && now.hour<20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch(e){
      print('Error: $e');
      time='could not load timezone';
    }
  }
}
