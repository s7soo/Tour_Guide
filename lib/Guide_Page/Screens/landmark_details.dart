
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Roundedbutton.dart';
import 'package:tour_guide/General_Page/components/Scaffold_menu.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/Guide_Page/models/slide_show.dart';
import 'package:tour_guide/nearby_places/screens/map_screen.dart';
import 'package:tour_guide/weather_screen/components/location.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:toast/toast.dart';

class LandmarkDetails extends StatefulWidget {
  LandmarkDetails({required this.name,required this.image,this.details, this.lat, this.lon, this.address,this.imageArray});
  final name;
  final image;
  final details;
  final lat;
  final lon;
  final imageArray;
  final address;

  @override
  State<LandmarkDetails> createState() => _LandmarkDetailsState();
}

class _LandmarkDetailsState extends State<LandmarkDetails> {
  var landAdress;
  var myAdress;
  var mylat;
  var mylon;

  var textcolor = Colors.black;
  var iconcolor = Colors.black;
  var buttoncolor = Colors.white;

  bool _isPressed = false;


  Future<void> getLandAddress() async {
    Location location = Location();
    await location.getAddress(widget.lat, widget.lon);
    landAdress = location.addressLatLng;
  }

  Future<void> getMyAddress() async {
    Location location = Location();
    await location.getLocation();
    mylat = location.lat;
    mylon = location.long;
    await location.getAddress(mylat,mylon);
    myAdress = location.addressLatLng;
  }


  Widget getItems() {
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 2)),
        builder: (context, snapshot) {
          String urlremoved = widget.details;

          List<String> spec_list = urlremoved.split(".");
          int speclistlen = spec_list.length-1;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: speclistlen,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: 10),
                        Text("⦿ ${spec_list[index]}"),
                        SizedBox(height: 10,child: Divider(),),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        });
  }
  Future createUser(String name,String image,String details,double lat,double lon,List<String> images) async {
    final geopoint = GeoPoint(lat,lon);
    final docUser = FirebaseFirestore.instance.collection('Bookmark');
    final json = {
      'Name': name,
      'Image': image,
      'details':details,
      'Location': geopoint,
      'Images': images
    };
    // await docUser.add(json);
    await docUser.doc(name).set(json);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ToastContext().init(context);
  }
  Widget build(BuildContext context) {
    return ScaffoldMenu(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
            child: SlideShow(imageArray: widget.imageArray),
          ),//slide-show
          Container(
            margin: EdgeInsets.only(top: 10),
            child: DefaultTextStyle(style: TextStyle(
              letterSpacing: 2,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: detailsTextColor,
            ),
                child: Text(widget.name,textAlign: TextAlign.center,)
            ),
          ),//title
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.place
                          ),
                          DefaultTextStyle(style: TextStyle(
                            fontSize: 12,
                            color: Colors.black
                          ), child: Text('Nearby Services'))
                        ],
                      ),
                      colour: Colors.white,
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            MapScreen(latitude: widget.lat,longitude: widget.lon)));
                      }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: RoundedButton(
                      child: Row(
                        children: [
                          Icon(
                              Icons.place
                          ),
                          DefaultTextStyle(style: TextStyle(
                              color: Colors.black,
                            fontSize: 12,
                          ), child: Text('Show The Way'))
                        ],
                      ),
                      colour: Colors.white,
                      onPressed: () async {
                        await MapsLauncher.launchCoordinates(widget.lat,widget.lon);

                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RoundedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: iconcolor,
                    ),
                    DefaultTextStyle(style: TextStyle(
                        color: textcolor,
                        fontSize: 12
                    ), child: Text('Bookmark'))
                  ],
                ),
                colour: buttoncolor,
                onPressed:
                    () async {
                  setState(() {
                    textcolor == Colors.black ?textcolor = Colors.white :textcolor = Colors.black;
                    buttoncolor == Colors.black ? buttoncolor = Colors.white : buttoncolor = Colors.black;
                    iconcolor == Colors.black ? iconcolor = Colors.white : iconcolor = Colors.black;
                    _isPressed = true;
                  });
                  final snapshot = await FirebaseFirestore.instance.collection('Bookmark').doc(widget.name).get();
                  if(!snapshot.exists){
                    createUser(
                        widget.name,
                        widget.image,
                        widget.details,
                        widget.lon,
                        widget.lat,
                        widget.imageArray
                    );
                    Toast.show(
                        "${widget.name} Bookmarked",
                        duration: Toast.lengthLong,
                        gravity:  Toast.bottom,
                        backgroundColor: Colors.lightBlue
                    );
                  }else {
                    print('>>>>>>>>>>>>> Document already exist <<<<<<<<<<<<<<<<');
                    Toast.show(
                      "${widget.name} Already Bookmarked",
                      duration: Toast.lengthLong,
                      gravity:  Toast.bottom,
                      backgroundColor: Colors.red,
                    );
                    // Fluttertoast.showToast(
                    //     msg: 'Some Fiedls are empty',
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.TOP,
                    //     timeInSecForIosWeb: 3,
                    //     backgroundColor: Colors.blueAccent,
                    //     textColor: Colors.black
                    // );
                  }
                }
            ),
          ),// two buttons
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: getItems()
            ),
          ),

        ],
      )
    );
  }
}


// body: DecorativeContainer(
// height: 500,
// color: primaryColor,
// widget: Padding(
// padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0),
// child: ListView(
// children: [
// DecorativeContainer(
// height: 300,
// color: boxColor.withOpacity(0.5),
// widget: Padding(
// padding: const EdgeInsets.all(5.0),
// child: SlideShow(),
// // child: Image(
// //   image: NetworkImage(image),
// //   fit: BoxFit.cover,
// // ),
// ),
// ),
// SizedBox(height: 5),
// DecorativeContainer(
// color: boxColor.withOpacity(0.5),
// height: name.toString().length.toDouble()*4.5,
// widget: Center(
// child: DefaultTextStyle(
// child: Text(name),
// style: TextStyle(
// letterSpacing: 2,
// fontSize: 25,
// fontWeight: FontWeight.bold,
// color: detailsTextColor,
// ),
// )
// ),
// ),
// SizedBox(height: 5),
// // DecorativeContainer(
// //   color: boxColor.withOpacity(0.5),
// //   height: details.toString().length.toDouble()/2.5,
// //   widget: Expanded(
// //     child: Padding(
// //       padding: const EdgeInsets.only(left: 4.0,right: 4),
// //       child: Center(
// //         child: DefaultTextStyle(
// //           style: TextStyle(
// //               fontSize: 12,
// //               color: detailsTextColor
// //           ),
// //           child: Text(details),
// //         ),
// //       ),
// //     ),
// //   ),
// // ),
// SizedBox(height: 5),
// DecorativeContainer(
// color: boxColor.withOpacity(0.5),
// height: 50,
// widget: Expanded(
// child: Padding(
// padding: const EdgeInsets.only(left: 4.0,right: 4),
// child: Center(
// child: DefaultTextStyle(
// style: TextStyle(
// fontSize: 12,
// color: detailsTextColor
// ),
// child: Text('underConstruction')
// ),
// ),
// ),
// ),
// ),
// SizedBox(height: 5,),
// Row(
// children: [
// Expanded(
// child: GestureDetector(
// child: DecorativeContainer(
// color: boxColor.withOpacity(0.5),
// widget: Icon(
// Icons.location_on,
// size: 50,
// ),
// ),
// onTap: () async {
// // await getLandAddress();
// // await getMyAddress();
// // Navigator.push(context, MaterialPageRoute(builder: (context) =>
// //     ShortestPath2(
// //       landAdress: address,
// //       myAdress: myAdress
// // )));
// },
// ),
// ),
// Expanded(
// child: GestureDetector(
// child: DecorativeContainer(
// color: boxColor.withOpacity(0.5),
// widget: Icon(
// Icons.near_me,
// size: 50,
// ),
// ),
// onTap: () async {
// // await getLandAddress();
// // await getMyAddress();
// // Navigator.push(context, MaterialPageRoute(builder: (context) =>
// //     MapScreen(latitude: lat,longitude: lon)));
// },
// ),
// ),
// ],
// )
// ],
// ),
// ),
// ),