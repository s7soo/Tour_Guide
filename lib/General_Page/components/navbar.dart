import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tour_guide/FlightBooking/screens/booking_screen.dart';
import 'package:tour_guide/General_Page/Screens/bookmark.dart';
import 'package:tour_guide/General_Page/components/search_bar.dart';
import 'package:tour_guide/Guide_Page/models/ancient_stream.dart';
import 'package:tour_guide/data.dart';
import 'package:tour_guide/weather_screen/screens/loading_screen.dart';
import 'package:tour_guide/translate_screen/mainPage.dart';

class NavBar extends StatelessWidget {
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            IconButton(onPressed: ()=> Navigator.pop(context),
                alignment: Alignment.bottomCenter,
                icon: Icon(
                Icons.clear,
              size: 35,
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            )),
            SizedBox(height: 10,),
            ListTile(
              trailing: Icon(Icons.wb_sunny),
              title: Text('Weather',textAlign: TextAlign.right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                return LoadingScreen();
              })),
            ),
            ListTile(
              trailing: Icon(Icons.language),
              title: Text('Translation',textAlign: TextAlign.right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                return MainPage();
              })),
            ),
            ListTile(
              trailing: Icon(Icons.flight),
              title: Text('Saving Itinerary',textAlign: TextAlign.right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                return BookingPage();
              })),
            ),
            ListTile(
              trailing: Icon(Icons.bookmark),
              title: Text('Bookmark',textAlign: TextAlign.right,),
              onTap: ()  =>  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return BookMark();
              })),
            ),
            Divider(),
            ListTile(
              title: Text('Exit',textAlign: TextAlign.right),
              trailing: Icon(Icons.exit_to_app),
              onTap: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }
}
