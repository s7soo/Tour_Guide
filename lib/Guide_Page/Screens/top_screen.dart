import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tour_guide/Guide_Page/models/ancient_stream.dart';
import 'package:tour_guide/Guide_Page/models/info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopAncientStream extends StatefulWidget {
  final path;
  final ontap;
  final searchtxt;
  TopAncientStream({@required this.path,this.ontap,this.searchtxt=''});

  @override
  State<TopAncientStream> createState() => _TopAncientStreamState();
}

class _TopAncientStreamState extends State<TopAncientStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ( widget.searchtxt!= "" && widget.searchtxt!= null)?FirebaseFirestore.instance.collection(widget.path).where("Name",isNotEqualTo:widget.searchtxt).orderBy("Name").startAt([widget.searchtxt,])
          .endAt([widget.searchtxt+'\uf8ff',])
          .snapshots()
          :FirebaseFirestore.instance.collection(widget.path).snapshots(),
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
          for (var collected in collection) {
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
              ontap: widget.ontap,
            );
            ancients.add(collectionWidget);
          }
        }catch(e){
          print('problems in stream builder TOP \n error : $e');
        }
        return Expanded(
            child:ListView(
              children: ancients,
            )
        );
      } ,
    );
  }
}
