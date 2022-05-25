import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:tour_guide/FlightBooking/screens/booking_screen.dart';

class CountryPicker extends StatefulWidget {

  String dOrA = '';
  CountryPicker(this.dOrA);

  @override
  CountryPickerState createState() => CountryPickerState();
}

class CountryPickerState extends State<CountryPicker> {

  static late String countryValue = '';
  static late String stateValue = '';
  static late String cityValue = '';





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Country State and City Picker'),
      ),
      body:  Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 600,
          child:
          Column(
            children: [
              SelectState(
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged:(value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged:(value) {
                  setState(() {
                    cityValue = value;
                    if(widget.dOrA == 'd'){
                      BookingPageState.departureCity = cityValue;
                    }
                    else if(widget.dOrA == 'a'){
                      BookingPageState.arrivalCity = cityValue;
                    }
                  });
                },


              ),
              // InkWell(
              //   onTap:(){
              //     print('country selected is $countryValue');
              //     print('country selected is $stateValue');
              //     print('country selected is $cityValue');
              //   },
              //  child: Text('Check')
              // )
            ],
          )
      ),
    );
  }
}