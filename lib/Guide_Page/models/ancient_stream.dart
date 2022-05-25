
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var collected;
class AncientStream extends StatelessWidget {
  final path;
  final ontap;
  final searchtxt;

  AncientStream({required this.path,this.ontap,this.searchtxt = ''});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ( searchtxt!= "" && searchtxt!= null)?FirebaseFirestore.instance.collection(path).where("Name",isNotEqualTo:searchtxt).orderBy("Name").startAt([searchtxt,])
          .endAt([searchtxt+'\uf8ff',])
          .snapshots()
          :FirebaseFirestore.instance.collection(path).snapshots(),
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
          final collection = snapshot.data!.docs.reversed;
          for (collected in collection) {
            final name = collected['Name'];
            final image = collected['Image'];
            final details = collected['details'];
            List<String> imageArray = List.from(collected['Images']);
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
              imageArray: imageArray,
              collect: collected,
              ontap: ontap,
            );

            ancients.add(collectionWidget);
          }
        }catch(e){
          print('problems in stream builder \n error : $e');
        }
        return Expanded(
            child:ListView(
              children: ancients,
            )
        );
      }
    );
  }
}







