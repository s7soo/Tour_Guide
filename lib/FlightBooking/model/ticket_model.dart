import 'package:tour_guide/FlightBooking/model/flight_booking_output_model.dart';

class TicketModel{

  final departureDateTime;
  final arrivalDateTime;
  final stopOversCount;
  final price;
  final handoffUrl;

  const TicketModel( {
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.stopOversCount,
    required this.price,
    required this.handoffUrl
  });

  factory TicketModel.fromFlightBookingOutputModel(FlightBookingOutputModel flightOutputModel,int ticketIndex) {
    return TicketModel(
      departureDateTime: flightOutputModel.legs[ticketIndex]['departureDateTime'],
      arrivalDateTime: flightOutputModel.legs[ticketIndex]['arrivalDateTime'],
      stopOversCount: flightOutputModel.legs[ticketIndex]['stopoversCount'],
      price: flightOutputModel.fares[ticketIndex]['price']['totalAmount'],
      handoffUrl: flightOutputModel.fares[ticketIndex]['handoffUrl'],
    );
  }

  @override
  String toString() {
    return 'TicketModel-> departureDateTime: $departureDateTime, arrivalDateTime: $arrivalDateTime, stopOversCount: $stopOversCount, price: $price, handofURL :$handoffUrl';
  }




}