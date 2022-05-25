import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/Guide_Page/models/ancient_stream.dart';
import 'package:tour_guide/General_Page/components/cities_data.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/Guide_Page/models/info_box.dart';
import 'package:tour_guide/data.dart';


class Update extends StatefulWidget {


  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

  String selectedCity = 'England';
  // String selectedCity = Data().selectedCity;
  final firestore =FirebaseFirestore.instance;
  final controllerName = Data().textFieldName;
  final controllerImage = Data().textFieldImage;
  final controllerLon = Data().currentLon;
  final controllerLat = Data().currentLat;
  final controllerDetails = Data().textFieldDetails;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection(selectedCity).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          List<InfoBox> ancients = [];
          try {
            final collection = snapshot.data!.docs;
            for (collected in collection) {
              final name = collected['Name'];
              final image = collected['Image'];
              final details = collected['details'];
              final location = collected['Location'];
              GeoPoint geoPoint = location;
              final lat = geoPoint.latitude;
              final lon = geoPoint.longitude;

              final collectionWidget = InfoBox(
                ancientName: name,
                ancientImage: image,
                ancientDetails: details,
                lon: lon,
                lat: lat,
                collect: collected,
                ontap: 2,
              );

              ancients.add(collectionWidget);
            }
          }catch(e){
            print('problems in stream builder \n error : $e');
          }
        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
            body: Container(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 16),
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
                  Expanded(
                      child:ListView(
                        children: ancients,
                      )
                  )
                ],
              )
            ),
          ),
        );
      }
    );
  }
}
class UpdatedListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

      ],
    );
  }
}
