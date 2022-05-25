class FlightBookingInputModel{

  final String tripType;
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String numberOfAdults;
  final String numberOfChildren;
  final String numberOfInfants;
  final String cabinClass;

  const FlightBookingInputModel({
    this.tripType = 'onewaytrip',
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.numberOfInfants,
    required this.cabinClass,
  });

}

