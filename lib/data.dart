

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_guide/General_Page/Screens/home_screen.dart';

import 'Guide_Page/models/info_box.dart';

class Data{
  Data({this.textFieldDetails,this.textFieldImage,
      this.textFieldLatitude,this.textFieldLongitude,this.textFieldName,
      this.currentLat,this.currentLon,this.selectedCity});

  final textFieldLatitude;
  final textFieldLongitude;
  final textFieldName;
  final textFieldImage;
  final textFieldDetails;
  List<InfoBox> bookmarks = [];
  late final currentLat;
  late final currentLon;
  bool visible = false;

  final selectedCity;

  // void updateTextFields(var name,var image,var details,var lat,var lon){
  //   textFieldName = name;
  //   textFieldImage = image;
  //   textFieldDetails = details;
  //   textFieldLatitude = lat;
  //   textFieldLongitude = lon;
  // }
  void updateCurrentLocation(double lat,double lon){
    currentLon = lon;
    currentLat = lat;
  }
  void updateVisible(bool visible){
    this.visible = visible;
  }
  GeoPoint getUserLocation(){
    final geoPoint = GeoPoint(double.parse(textFieldLatitude), double.parse(textFieldLongitude));
    return geoPoint;
  }
  GeoPoint getMyLocation(){
    final geoPoint = GeoPoint(currentLat,currentLon);
    return geoPoint;
  }
  void printText(){
    print("name: $textFieldName || image: $textFieldImage");
    print("details: $textFieldDetails");
    print("lat:$textFieldLatitude || lon: $textFieldLongitude");
  }

}

