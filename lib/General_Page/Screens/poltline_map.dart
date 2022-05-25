import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ShortestPath extends StatefulWidget {
  final landmarkAddress;
  final myAddress;
  final landlat;
  final landlon;
  final mylat;
  final mylon;

  final apiKey= "AIzaSyCXKvaEoZ3IPetgGzz8bMGF_4H8FAJ129k";

  const ShortestPath({this.landmarkAddress, this.myAddress, this.landlat, this.landlon, this.mylat, this.mylon});

  @override
  State<ShortestPath> createState() => _ShortestPathState();
}

class _ShortestPathState extends State<ShortestPath> {
  Set<Polyline> polyline = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  late GoogleMapController _controller;
  // Completer<GoogleMapController> _controller = Completer();
  late List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
  new GoogleMapPolyline(apiKey: "AIzaSyCQGBbmGBCTdR9tBTQ7KSqjCGb3CmXsj1w");

  getsomePoints() async {
      routeCoords = (await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(widget.mylat, widget.mylon),
          destination: LatLng(widget.landlat, widget.landlon),
          mode: RouteMode.driving))!;
  }

  getaddressPoints() async {
    routeCoords = (await googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: widget.myAddress,
        destination: widget.landmarkAddress,
        mode: RouteMode.driving))!;
  }
  void setPolylines() async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates("AIzaSyCQGBbmGBCTdR9tBTQ7KSqjCGb3CmXsj1w",
        PointLatLng(widget.mylat, widget.mylon),
        PointLatLng(widget.landlat, widget.landlon));

    if(result.status == 'OK'){
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        polyline.add(Polyline(
            polylineId: PolylineId('1'),
            visible: true,
            points: polylineCoordinates,
            width: 10,
            color: Colors.blue,
            ));
      });
    }
  }
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    getaddressPoints();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            // onMapCreated: onMapCreated,
            onMapCreated: onMapCreated,
            polylines: polyline,
            initialCameraPosition:
            CameraPosition(target: LatLng(widget.mylat, widget.mylon), zoom: 14.0),
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            compassEnabled: true,
          ),
        ));
  }
  void onMapCreated(GoogleMapController controller) async {

    print(">>>>>>>>>>>>>>>> $routeCoords <<<<<<<<<<<<<<<<<<<<<");
    print(">>>>>>>>>>>>>>>> $polylineCoordinates<<<<<<<<<<<<<<<<<<<<");
    setState(() {
      _controller = controller;
      setPolylines();

      polyline.add( Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }
}


