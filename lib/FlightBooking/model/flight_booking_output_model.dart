class FlightBookingOutputModel{
  final legs;
  final fares;


  const FlightBookingOutputModel({
  required this.legs,
  required this.fares
  });

  factory FlightBookingOutputModel.fromJson(Map<String, dynamic> json) {
    return FlightBookingOutputModel(
     legs: json['legs'],
     fares: json['fares'],
  );
  }

  @override
  String toString() {
    return 'FlightBookingOutputModel{fares: ${fares[0]}';
  }

}
