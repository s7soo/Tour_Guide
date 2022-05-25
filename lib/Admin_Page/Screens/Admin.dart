import 'package:flutter/material.dart';
import 'package:tour_guide/Admin_Page/Screens/add.dart';
import 'package:tour_guide/Admin_Page/Screens/update.dart';
import 'package:tour_guide/General_Page/components/constants.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                unselectedLabelColor: primaryColor,
                tabs: [
                  Tab(text: 'Create',),
                  Tab(text: 'Update/Delete',)
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Add(),
            Update(),
          ],
        ),
      ),
    );
  }
}

