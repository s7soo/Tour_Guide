import 'dart:convert';

import 'package:tour_guide/FlightBooking/constants/booking_api_key_constant.dart';

import '../model/IATA_model.dart';
import 'package:http/http.dart' as http;

class IATAAPI{

  static Future<IATAModel> fetchIATA(String city) async{

  final String apiKey = BookingApiKeyConstant.API_KEY;

  final response = await http.get(Uri.parse('https://api.flightapi.io/iata/$apiKey/$city/airport'));
  if (response.statusCode == 200) {
  // If the server did return a 200 OK response,
  // then parse the JSON.
      return IATAModel.fromJson(jsonDecode(response.body));
  } else {
  // If the server did not return a 200 OK response,
  // then throw an exception.
  throw Exception('Failed to load ');
  }

  }

}