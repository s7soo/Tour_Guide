import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/FlightBooking/model/country_picker.dart';
import 'package:tour_guide/FlightBooking/screens/tickets_list_screen.dart';
import '../../General_Page/components/Scaffold_menu.dart';
import '../API/flight_booking_output_api.dart';
import '../model/flight_booking_input_model.dart';
import '../model/flight_booking_output_model.dart';
import 'package:tour_guide/weather_screen/components/location.dart';
import 'package:toast/toast.dart';

class BookingPage extends StatefulWidget {
  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  late FlightBookingInputModel bookingInput;
  TextEditingController departureCityController = TextEditingController();
  TextEditingController arrivalCityController = TextEditingController();
  TextEditingController numOfAdultsController = TextEditingController();
  TextEditingController numOfChildrenController = TextEditingController();
  TextEditingController numOfInfantsController = TextEditingController();
  TextEditingController departureDateController = TextEditingController();

  static String departureCity = '';
  static String arrivalCity = '';


  List<String> cabinetClassOptions = [
    'Economy',
    'Business',
    'First',
    'Premium_Economy'
  ];
  String? cabinetClassSelected = 'Economy';

  DateTime currentDate = DateTime.now();
  String dateStringFormat = '';
  String myAdress = '';
  String myCity = '';
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bookingInput = FlightBookingInputModel(
    //     tripType: 'onewaytrip',
    //     departureCity: 'HBE',
    //     arrivalCity: 'RUH',
    //     departureDate: '2022-05-20',
    //     numberOfAdults: 1,
    //     numberOfChildren: 0,
    //     numberOfInfants: 0,
    //     cabinClass: "Economy");
    //
    // fetchBookingOutput();
    // getMyAddress();
  }

  Future<void> getMyAddress() async {
    isLoading = true;
    Location location = Location();
    await location.getLocation();
    final mylat = location.lat;
    final mylon = location.long;
    await location.getAddress(mylat, mylon);
    myAdress = location.addressLatLng;
    myCity = myAdress.split(',').elementAt(1).trim().toLowerCase();
    departureCityController.text = myCity;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMenu(
      resizeToAvoidBottomInset: false,
      body:
      Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Expanded(
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         prefixIcon: Icon(Icons.location_city),
                  //         hintText: 'From',
                  //         labelText: 'Departure City',
                  //         border: OutlineInputBorder()),
                  //     textInputAction: TextInputAction.done,
                  //     controller: departureCityController
                  //
                  //   ),
                  // ),
                  // Expanded(
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         prefixIcon: Icon(Icons.location_city),
                  //         hintText: 'To',
                  //         labelText: 'Arrival City',
                  //         border: OutlineInputBorder()),
                  //     textInputAction: TextInputAction.done,
                  //     controller: arrivalCityController,
                  //   ),
                  // ),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) {

                            return CountryPicker('d');

                          }


                          )
                          );
                        },
                        child: Text('Choose Departure City'),
                      )),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {

                            return CountryPicker('a');
                          }


                          )
                          );
                        },

                        child: Text('Choose Arrival City'),
                      ))
                ],
              ),
            ),
            // Expanded(
            //   child: TextField(
            //     decoration: InputDecoration(
            //         labelText: 'Trip Type',
            //         hintText: "onewaytrip/",
            //         border: OutlineInputBorder()),
            //     textInputAction: TextInputAction.done,
            //     controller: tripTypeController,
            //   ),
            // ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Number of adults',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
                controller: numOfAdultsController,
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Number of children',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
                controller: numOfChildrenController,
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Number of infants',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
                controller: numOfInfantsController,
              ),
            ),
            // Expanded(
            //   child: TextField(
            //     decoration: InputDecoration(
            //         labelText: 'Departure date',
            //         hintText: "year-month-day",
            //         border: OutlineInputBorder()),
            //     textInputAction: TextInputAction.done,
            //     controller: departureDateController,
            //   ),
            // ),

            Expanded(
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue))),
                  value: cabinetClassSelected,
                  items: cabinetClassOptions
                      .map((item) => DropdownMenuItem<String>(
                      value: item, child: Text(item)))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      cabinetClassSelected = item.toString();
                    });
                  }),
            )
            // Expanded(
            //   child: TextField(
            //     decoration: InputDecoration(
            //         labelText: 'Cabinet Class',
            //         hintText: "Economy/Business/First/Premium_Economy",
            //         border: OutlineInputBorder()),
            //     textInputAction: TextInputAction.done,
            //     controller: cabinetClassController,
            //   ),
            // ),

            ,
            ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: currentDate.add(Duration(days: 600)));
                if (newDate == null) {
                  return;
                }
                setState(() {
                  currentDate = newDate;
                  dateStringFormat = newDate.year.toString() +
                      '-' +
                      newDate.month.toString() +
                      '-' +
                      newDate.day.toString();
                });
              },
              child: Text('Select Trip Departure Date'),
            ),

            ElevatedButton(
              onPressed: () async {
                ToastContext().init(context);
                if (departureCity == '' || arrivalCity == '' || numOfAdultsController.text == '' || numOfChildrenController.text == ''
                || numOfInfantsController.text == '') {
                  Toast.show('Some fields are empty', gravity: Toast.bottom,
                    duration: Toast.lengthLong, backgroundColor: Colors.red,webTexColor: Colors.yellow);
                } else
                setState(() {
                  isLoading = true;
                });

                bookingInput = FlightBookingInputModel(
                    departureCity: departureCity.toLowerCase().trim(),
                    arrivalCity: arrivalCity.toLowerCase().trim(),
                    departureDate: dateStringFormat,
                    numberOfAdults: numOfAdultsController.text,
                    numberOfChildren: numOfChildrenController.text,
                    numberOfInfants: numOfInfantsController.text,
                    cabinClass: cabinetClassSelected ?? '');

                // FlightBookingOutputModel flightBookingOutputModel = await fetchBookingOutput();

                FlightBookingOutputModel? flightBookingOutputModel =
                await FlightBookingOutputAPI.fetchFlightBookingOutput(
                    bookingInput);

                if(flightBookingOutputModel?.legs.length == 0 || flightBookingOutputModel == null){
                  setState(() {
                    isLoading = false;
                  });
                  Toast.show("Tickets not found", duration: Toast.lengthLong, gravity: Toast.bottom);
                  return;
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return TicketsListPage(
                          flightBookingOutputModel: flightBookingOutputModel);
                    }));

              },
              child: isLoading?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white,),
                  SizedBox(width: 30,),
                  Text("Loading Tickets...")
                ],
              ):Text("Search For Tickets"),

            ),
          ],
        ),
      ),
    );
  }

  Future<FlightBookingOutputModel> fetchBookingOutput() async {
    return await FlightBookingOutputAPI.fetchFlightBookingOutput(bookingInput);
  }
}