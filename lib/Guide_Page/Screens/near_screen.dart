import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/Guide_Page/models/info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_guide/Guide_Page/Screens/landmark_details.dart';

class NearAncientStream extends StatelessWidget {
  final path;
  NearAncientStream({@required this.path});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection(path).snapshots(),
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
          for (var collect in collection) {
            final name = collect['Name'];
            final image = collect['Image'];
            final details = collect['details'];
            final collectionWidget = InfoBox(
              ancientName: name,
              ancientImage: image,
              ancientDetails: details,
            );
            ancients.add(collectionWidget);
          }
        }catch(e){
          print('problems in stream builder NEAR \n error : $e');
        }
        return Expanded(
            child:ListView.builder(
              itemCount: ancients.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            LandmarkDetails(
                                name: ancients[index].ancientName,
                                image: ancients[index].ancientImage,
                                details: ancients[index].ancientDetails,
                            )
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/bg2.png'),
                            fit: BoxFit.fitWidth
                        ),
                        color: boxColor.withOpacity(0.5),
                        border: Border.all(color: borderColor, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: new Image.network(ancients[index].ancientImage),
                      title: new Text(ancients[index].ancientName),
                    ),
                  ),
                );
              },
            )
        );
      } ,
    );
  }
}