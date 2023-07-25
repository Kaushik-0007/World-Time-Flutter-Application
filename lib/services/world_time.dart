import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for the UI
  String time=""; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDayTime=false; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

  try {
  //make the request
  Response response= await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
  Map data=jsonDecode(response.body);
  //print(data);

  //get properties from data

  String datetime= data['utc_datetime'];
  String plusOrMinus = data['utc_offset'].substring(0,1);
  String offset1= data['utc_offset'].substring(1,3);
  String offset2= data['utc_offset'].substring(4,6);
  //print(datetime);
  //print(offset);

  //create DateTime Object

  DateTime now= DateTime.parse(datetime);
  if(plusOrMinus == '-'){
    now=now.subtract(Duration(hours:int.parse(offset1),minutes:int.parse(offset2)));
  }else{
    now=now.add(Duration(hours:int.parse(offset1),minutes:int.parse(offset2)));
  }


  //set the time property
  isDayTime=now.hour>6 && now.hour<20;
  time=DateFormat.jm().format(now);
  }

  catch(e) {
    print('Caught error : $e');
    time='Could not retrieve time data';
  }


  }

}