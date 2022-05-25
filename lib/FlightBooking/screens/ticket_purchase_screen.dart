import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketPurchasePage extends StatefulWidget {

  final handoffUrl;
  TicketPurchasePage(this.handoffUrl);

  @override
  _TicketPurchasePageState createState() => _TicketPurchasePageState();
}

class _TicketPurchasePageState extends State<TicketPurchasePage> {

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final url = widget.handoffUrl;

    launchTicketPurchaseWebsite(url);

  }
  void launchTicketPurchaseWebsite(String url) async{
    isLoading = true;
    if(await canLaunch(url)){
      await launch(url,
      forceSafariVC: false,);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return isLoading?CircularProgressIndicator():Container();

  }


}
