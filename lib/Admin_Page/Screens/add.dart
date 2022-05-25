import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Roundedbutton.dart';
import 'package:tour_guide/General_Page/components/cities_data.dart';
import 'package:tour_guide/General_Page/components/constants.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String selectedCity = 'Egypt';

  final controllerName = TextEditingController();
  final controllerImage = TextEditingController();
  final controllerLon = TextEditingController();
  final controllerLat = TextEditingController();
  final controllerDetails = TextEditingController();
  final controllerImages = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(0),
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
              SizedBox(height: 10,),
              TextField(
                controller: controllerName,
                textAlign: TextAlign.center,
                decoration:
                kAdminFieldDecoration.copyWith(hintText: 'Name of landmark'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: controllerImage,
                textAlign: TextAlign.center,
                decoration:
                kAdminFieldDecoration.copyWith(hintText: 'Link of image'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: controllerImages,
                textAlign: TextAlign.center,
                decoration:
                kAdminFieldDecoration.copyWith(hintText: 'Link of another image'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: controllerDetails,
                textAlign: TextAlign.center,
                decoration:
                kAdminFieldDecoration.copyWith(hintText: 'Details about landmark'),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controllerLat,
                      textAlign: TextAlign.center,
                      decoration:
                      kAdminFieldDecoration.copyWith(hintText: 'Latitude'),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      controller: controllerLon,
                      textAlign: TextAlign.center,
                      decoration:
                      kAdminFieldDecoration.copyWith(hintText: 'Longitude'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              RoundedButton(child: Text(
                'Add',
                style: TextStyle(
                  color: bigTextColor,
                ),
              ), colour: Colors.lightBlueAccent,
                  onPressed: (){

                createUser(controllerName.text,controllerImage.text,controllerDetails.text,double.parse(controllerLat.text),double.parse(controllerLon.text),controllerImages.text);
                controllerName.clear();
                controllerImage.clear();
                controllerDetails.clear();
                controllerLon.clear();
                controllerLat.clear();
              }
              )
            ],
          ),
        ),
      ),
    );
  }

  Future createUser(String name,String image,String details,double lat,double lon,String images) async {
    final geopoint = GeoPoint(lat,lon);
    List<String> imageArray = [];
    imageArray.add(images);
    final docUser = FirebaseFirestore.instance.collection(selectedCity);
    final json = {
      'Name': name,
      'Image': image,
      'details':details,
      'Location': geopoint,
      'ImageArray': imageArray
    };
    await docUser.add(json);

  }
}