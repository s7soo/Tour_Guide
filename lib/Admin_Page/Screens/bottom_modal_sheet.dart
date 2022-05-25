import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Roundedbutton.dart';
import 'package:tour_guide/General_Page/components/constants.dart';

class BottomModalSheet extends StatelessWidget {
  const BottomModalSheet({this.name, this.image, this.details, this.lat, this.lon, this.updatefn, this.deletefn});
  final name;
  final image;
  final details;
  final lat;
  final lon;
  final updatefn;
  final deletefn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
          children: [
            TextField(
              controller: name,
              textAlign: TextAlign.center,
              decoration:
              kAdminFieldDecoration.copyWith(hintText: 'Name of landmark'),
            ),
            TextField(
              controller: image,
              textAlign: TextAlign.center,
              decoration:
              kAdminFieldDecoration.copyWith(hintText: 'link of image'),
            ),
            TextField(
              controller: details,
              textAlign: TextAlign.center,
              decoration:
              kAdminFieldDecoration.copyWith(hintText: 'Details of landmark'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: lat,
                    textAlign: TextAlign.center,
                    decoration:
                    kAdminFieldDecoration.copyWith(hintText: 'Landmark Latitude'),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: TextField(
                    controller: lon,
                    textAlign: TextAlign.center,
                    decoration:
                    kAdminFieldDecoration.copyWith(hintText: 'Landmark Longitude'),
                  ),
                ),
              ],
            ),
            RoundedButton(child: Text(
              'Update',
              style: TextStyle(
                color: bigTextColor,
              ),
            ), colour: Colors.lightBlueAccent,
                onPressed: updatefn),
            RoundedButton(child: Text(
              'Delete',
              style: TextStyle(
                color: bigTextColor,
              ),
            ), colour: Colors.redAccent,
                onPressed: deletefn)
          ],
        ),
    );
  }
}
