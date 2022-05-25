import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/FlightBooking/screens/ticket_purchase_screen.dart';
import 'package:tour_guide/translate_screen/mainPage.dart';

import '../model/flight_booking_output_model.dart';
import '../model/ticket_model.dart';

class TicketsListPage extends StatefulWidget {
  FlightBookingOutputModel flightBookingOutputModel;
  TicketsListPage({required this.flightBookingOutputModel});
  @override
  _TicketsListPageState createState() => _TicketsListPageState();
}

class _TicketsListPageState extends State<TicketsListPage> {
  late TicketModel ticket;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ticket = TicketModel.fromFlightBookingOutputModel(widget.flightBookingOutputModel, 5);
    // print(ticket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tickets'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 24, right: 10, left: 10),
          child: ListView.builder(
              itemCount: widget.flightBookingOutputModel.legs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return getTicketItem(
                  TicketModel.fromFlightBookingOutputModel(
                      widget.flightBookingOutputModel, index),
                  context);
  }
        )));
  }

  Widget getTicketItem(TicketModel ticketItem, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(ticketItem.price);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TicketPurchasePage(ticketItem.handoffUrl);
        }));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Departure Date Time:\n${ticketItem.departureDateTime}",
                    ),
                    Text(
                      "Arrival Date Time:\n${ticketItem.arrivalDateTime}",
                    ),
                    Text("Stop Overs Count:\n${ticketItem.stopOversCount.toString()}"),
                    Text("Price:\n${ticketItem.price.toString()}"),
                  ],
                ))),
      ),
    );
  }
}
