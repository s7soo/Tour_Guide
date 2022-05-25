import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Scaffold_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_guide/Guide_Page/Screens/guide_screen.dart';
import 'package:tour_guide/Guide_Page/models/ancient_stream.dart';

import '../../Guide_Page/models/info_box.dart';
class BookMark extends StatefulWidget {
  String searchtxt = '';

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  final path = 'Bookmark';

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ( widget.searchtxt!= "" && widget.searchtxt!= null)?FirebaseFirestore.instance.collection(path).where("Name",isNotEqualTo:widget.searchtxt).orderBy("Name").startAt([widget.searchtxt,])
            .endAt([widget.searchtxt+'\uf8ff',])
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
            final collection = snapshot.data!.docs;
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
                ontap: 1,
                visible: true,
              );

              ancients.add(collectionWidget);
            }
          }catch(e){
            print('problems in Bookmark stream builder \n error : $e');
          }
          return ScaffoldMenu(
            resizeToAvoidBottomInset: false,
            title: Row(
                children:[
                  Expanded(
                    child: Visibility(
                      visible: visible,
                      child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Ex:Egypt Museum',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.white54
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value){
                            setState(() {

                              widget.searchtxt = value.toTitleCase();
                            });
                          }),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      setState(() {
                        if (visible == false) visible = true;
                        else visible = false;
                      });
                    },
                  ),
                ]),
            body: ListView(
              children: ancients,
            ),
          );
        }
    );
  }
}
