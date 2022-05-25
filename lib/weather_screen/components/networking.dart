import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{

  NetworkHelper(this.Url);
  final String Url;

  Future getData() async{
    var url = Uri.parse(Url);
    http.Response response = await http.get(url);
    String data = response.body;

    if(response.statusCode == 200) {
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}