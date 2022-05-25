
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/Admin_Page/Screens/Admin.dart';
import 'package:tour_guide/Guide_Page/Screens/guide_screen.dart';
import 'package:tour_guide/General_Page/components/cities_data.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/data.dart';

import 'package:geolocator/geolocator.dart';


class HomeScreen extends StatelessWidget {

  String getSelectedCity(){
    return selectedCity;
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: DropDownList()
    );
  }
}
class DropDownList extends StatefulWidget {

  @override

  _DropDownListState createState() => _DropDownListState();

}

String selectedCity = 'Egypt';
late double lat;
late double lon;


class _DropDownListState extends State<DropDownList> {
  @override
  void initState() {
    super.initState();
    getGeoLocationPosition();
    setLonLat();

  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return position;
  }
  setLonLat() async {
    var currentLocation = await getGeoLocationPosition();
    setState(() {
      lon = currentLocation.longitude;
      lat = currentLocation.latitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('Select Your City',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: bigTextColor,

              ),
            ),
          ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          decoration: BoxDecoration(
              border: Border.all(color: buttonColor,width: 1),
              borderRadius: BorderRadius.circular(15)
          ),
          child: DropdownButton(
            underline: SizedBox(),
            dropdownColor:Colors.white.withOpacity(0.8), //menuColor.withOpacity(0.8),
            iconSize: 30,
            isExpanded: true,
            style: TextStyle(
                color: bigTextColor,
                fontWeight: FontWeight.bold
            ),
            value: selectedCity,
            onChanged: (newValue){
              setState(() {
                selectedCity = newValue.toString();
                final data = Data(selectedCity: selectedCity);
                print(data.selectedCity);
              });
            },
            items: city.map((valueItem){
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Material(
          elevation: 5.0,
          color: buttonColor,
          borderRadius: BorderRadius.circular(15.0),
          child: MaterialButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GuideScreen(city: selectedCity)));
              print(selectedCity);
              print(lon);
              print(lat);
              final data = Data(selectedCity: selectedCity);
              print(data.selectedCity);
            },
            minWidth: 350.0,
            height: 42.0,
            child: Text(
              'Guide',style: TextStyle(
                color: bigTextColor,
                fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            ),
          ),
        ),
      ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Admin()));
            },
            child: new Text("Continue as admin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          )
        ],
      ),
    );
  }
}
