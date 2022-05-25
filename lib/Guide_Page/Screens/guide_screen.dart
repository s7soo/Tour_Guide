import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Scaffold_menu.dart';
import 'package:tour_guide/Guide_Page/Screens/near_screen.dart';
import 'package:tour_guide/Guide_Page/Screens/top_screen.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
import 'package:tour_guide/Guide_Page/models/ancient_stream.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/General_Page/components/navbar.dart';
class GuideScreen extends StatefulWidget {
  GuideScreen({required this.city});
  static const String id = 'GuideScreen';
  final String city;
  String searchtxt='';
  bool visible = false;

  @override
  _GuideScreenState createState() => _GuideScreenState();
}
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class _GuideScreenState extends State<GuideScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ScaffoldMenu(
        title: Row(
            children:[
              Expanded(
                child: Visibility(
                  visible: widget.visible,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
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
                    if (widget.visible == false) widget.visible = true;
                    else widget.visible = false;
                  });
                },
              ),
            ]),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              tabs: [
                Tab(text: 'Guide',),
                Tab(text: 'Top',),
                // Tab(text: 'Near',),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AncientStream(path: widget.city,searchtxt: widget.searchtxt),
                  TopAncientStream(path: widget.city,searchtxt: widget.searchtxt),
                  // NearAncientStream(path: widget.city),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}