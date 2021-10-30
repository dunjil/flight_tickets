import 'package:flutter/material.dart';
import 'package:flight_tickets/CustomShapeClipper.dart';
import 'package:intl/intl.dart';
import 'package:flight_tickets/CustomAppBar.dart';
import 'package:flight_tickets/flightListScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flight App',
    theme: appTheme,
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

List<String> locations = ['Boston (BOS)', 'New York City (JFK)'];
Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);
final _searchController = TextEditingController(text: locations[1]);

final TextStyle dropDownButtonStyle =
    TextStyle(fontSize: 12.0, color: Colors.white);
final TextStyle dropDownMenuItemStyle =
    TextStyle(fontSize: 12.0, color: Colors.black);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          HomeScreenTopPart(),
          homeScreenBottomPart,
        ]),
      ),
      bottomNavigationBar: CustomAppBar(),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  int selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // ClipPath(
        //  clipper: CustomShapeClipper(),
        //child:
        Container(
          height: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [firstColor, secondColor]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    PopupMenuButton(
                      onSelected: (index) {
                        setState(() {
                          selectedLocationIndex = index;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            locations[selectedLocationIndex],
                            style: dropDownButtonStyle,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<int>>[
                            PopupMenuItem(
                              child: Text(
                                locations[0],
                                style: dropDownMenuItemStyle,
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Text(
                                locations[1],
                                style: dropDownMenuItemStyle,
                              ),
                              value: 1,
                            ),
                          ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Text(
                  "Where would you want to go?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextField(
                    controller: _searchController,
                    style: dropDownMenuItemStyle,
                    cursorColor: appTheme.primaryColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 5.0,
                      ),
                      border: InputBorder.none,
                      suffix: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: InkWell(
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InheritedFlightListScreen(
                                      fromLocation:
                                          locations[selectedLocationIndex],
                                      toLocation: _searchController.text,
                                      child: FlightListScreen(),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: ChoiceChip(
                        Icons.flight_takeoff, "Flights", isFlightSelected),
                    onTap: () {
                      setState(() {
                        isFlightSelected = !isFlightSelected;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  InkWell(
                    child: ChoiceChip(Icons.hotel, 'Hotels', !isFlightSelected),
                    onTap: () {
                      setState(() {
                        isFlightSelected = !isFlightSelected;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
        // ),
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  ChoiceChip(this.icon, this.text, this.isSelected);
  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.all(Radius.circular(20.0)))
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}

var bottomTextStyle = TextStyle(
    fontSize: 12.0, color: appTheme.primaryColor, fontWeight: FontWeight.bold);

Widget homeScreenBottomPart = Container(
    child: Column(
  children: <Widget>[
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Currently Watched Items',
            style: dropDownMenuItemStyle,
          ),
          Text(
            'VIEW ALL (12)',
            style: bottomTextStyle,
          ),
        ],
      ),
    ),
    Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards,
      ),
    ),
  ],
));
List<CityCard> cityCards = [
  CityCard(
      "assets/images/sydney.jpg", "Sydney", "June, 2019", 9999, 4322, "50%"),
  CityCard("assets/images/lasvegas.jpg", "Las Vegas", "June, 2019", 6746, 3865,
      "48%"),
  CityCard(
      "assets/images/athens.jpg", "Athens", "April, 2019", 3791, 89483, "33%"),
];
final formatCurrency = NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount;
  final int oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.oldPrice,
      this.newPrice, this.discount);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 170,
                  width: 140,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: 0.0,
                    width: 140.0,
                    height: 50.0,
                    bottom: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12]),
                      ),
                    )),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            cityName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            monthYear,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          discount,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 2.0),
              Text(
                '${formatCurrency.format(newPrice)}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              SizedBox(width: 5.0),
              Text(
                '${formatCurrency.format(oldPrice)}',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              )
            ],
          )
        ],
      ),
    );
  }
}
