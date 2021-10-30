import 'package:flutter/material.dart';
import 'package:flight_tickets/main.dart';

final Color discountBackgroundColor = Color(0xffffe080);
final Color flightBorderColor = Color(0xffe6e6e6);
final Color chipBackgroundColor = Color(0xfff6f6f6);

class InheritedFlightListScreen extends InheritedWidget {
  final String fromLocation, toLocation;
  const InheritedFlightListScreen({
    this.fromLocation,
    this.toLocation,
    Widget child,
  }) : super(child: child);

  static InheritedFlightListScreen of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedFlightListScreen);
  }

  @override
  bool updateShouldNotify(InheritedFlightListScreen old) => true;
}

class FlightListScreen extends StatelessWidget {
  var fromLocation;
  var toLocation;

  FlightListScreen({this.fromLocation, this.toLocation});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search List'),
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              FLightListTopPart(),
              SizedBox(
                height: 20.0,
              ),
              FlightListingBottomPart()
            ],
          ),
        ));
  }
}

class FLightListTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [firstColor, secondColor]),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: 120,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${InheritedFlightListScreen.of(context).fromLocation}',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            '${InheritedFlightListScreen.of(context).toLocation}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.import_export,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FlightListingBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Best deals for the next 6 months',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
            ],
          )
        ],
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: flightBorderColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${formatCurrency.format(500)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${(formatCurrency.format(9999))}',
                      style: TextStyle(
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    )
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    chipItem(Icons.calendar_today, 'June, 2019'),
                    chipItem(Icons.flight_takeoff, 'Jet Ways'),
                    chipItem(Icons.star, '4.4'),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: 10.0,
              right: -2.0,
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: discountBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text(
                  '55%',
                  style: TextStyle(fontSize: 10.0),
                ),
              ))
        ],
      ),
    );
  }

  Widget chipItem(IconData iconData, String label) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
      backgroundColor: chipBackgroundColor,
      avatar: Icon(
        iconData,
        size: 14.0,
      ),
    );
  }
}
