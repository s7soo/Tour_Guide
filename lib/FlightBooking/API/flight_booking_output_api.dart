import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour_guide/FlightBooking/API/iata_api.dart';
import 'package:tour_guide/FlightBooking/model/IATA_model.dart';

import '../constants/booking_api_key_constant.dart';
import '../model/flight_booking_input_model.dart';
import '../model/flight_booking_output_model.dart';

class FlightBookingOutputAPI{

  static Future fetchFlightBookingOutput(FlightBookingInputModel input) async {

    final String tripType = input.tripType;
    final departureCityIATAModel = await IATAAPI.fetchIATA(input.departureCity);
    final arrivalCityIATAModel = await IATAAPI.fetchIATA(input.arrivalCity);
    final String departureDate = input.departureDate;
    final String numberOfAdults = input.numberOfAdults;
    final String numberOfChildren = input.numberOfChildren;
    final String numberOfInfants = input.numberOfInfants;
    final String cabinClass = input.cabinClass;
    final String currency = "USD";


    // print(departureCityIATAModel);
    // print(arrivalCityIATAModel);

    final String departureCityIATAFirstCode = departureCityIATAModel.data[0]['iata'];
    final String arrivalCityIATAFirstCode = arrivalCityIATAModel.data[0]['iata'];

    final String apiKey = BookingApiKeyConstant.API_KEY;

    final response = await http.get(
        Uri.parse(
        'https://api.flightapi.io/$tripType/$apiKey/$departureCityIATAFirstCode/$arrivalCityIATAFirstCode/$departureDate/$numberOfAdults/$numberOfChildren/$numberOfInfants/$cabinClass/$currency'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return FlightBookingOutputModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

}