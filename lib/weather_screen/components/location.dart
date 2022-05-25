import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class Location {

  late double lat;
  late double long;
  late String addressLatLng;

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      long = position.longitude;
      print('location function works fine + $lat + $long');
    }
    catch(e){
      print(e);
    }
  }
  Future<void> getAddress(double lat, double lang) async {
    GeoCode geoCode = GeoCode();
    Address address = await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    addressLatLng = "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
    print("address function works fine + $addressLatLng");
  }

}