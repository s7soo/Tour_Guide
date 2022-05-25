import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/Scaffold_menu.dart';
import 'package:tour_guide/translate_screen/components/choose_language.dart';
import 'package:tour_guide/translate_screen/components/input_text.dart';
import 'package:tour_guide/translate_screen/components/translate_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMenu(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              ChooseLanguage(),
              InputText(),
              TranslateText(),
            ],
          ),
        ),
      ),
    );
  }
}

// AppBar buildAppBar() {
//   return AppBar(
//     title: Text('Google Translate'),
//     centerTitle: true,
//     elevation: 0.0,
//   );
// }
