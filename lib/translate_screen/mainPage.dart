import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/translate_screen/pages/home/home_page.dart';
import 'package:tour_guide/translate_screen/provider/translator_provider.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TranslatorData(),
      child: MaterialApp(
        title: 'Google Translate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff5848D9),
          scaffoldBackgroundColor: Color(0xfff9f9f9),
        ),
        home: HomePage(),
      ),
    );
  }
}
