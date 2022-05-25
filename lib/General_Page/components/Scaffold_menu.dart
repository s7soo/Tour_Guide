import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/navbar.dart';

class ScaffoldMenu extends StatelessWidget {
  final body;
  final resizeToAvoidBottomInset;
  final title;
  final floatingActionButton;
  const ScaffoldMenu({this.body,this.resizeToAvoidBottomInset=true,this.title,this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      drawerEdgeDragWidth: 10,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      endDrawer: NavBar(),
      appBar: AppBar(
          title: title,
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                  Icons.arrow_back
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
      ),
      body: body,
    );
  }
}
