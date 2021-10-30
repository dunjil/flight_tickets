import 'package:flutter/material.dart';
import 'package:flight_tickets/main.dart';

class CustomAppBar extends StatelessWidget {
  final List<BottomNavigationBarItem> barItems = [];
  CustomAppBar() {
    this.barItems.add(
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: appTheme.primaryColor,
              ),
              icon: Icon(
                Icons.home,
                color: appTheme.primaryColor,
              ),
              title: Text(
                'Explore',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.normal),
              )),
        );
    this.barItems.add(
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: Text(
                'Watch List',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.normal),
              )),
        );
    this.barItems.add(
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer,
                color: Colors.black,
              ),
              title: Text(
                'Deals',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.normal),
              )),
        );
    this.barItems.add(
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.black,
              ),
              title: Text(
                'Notifications',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.normal),
              )),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: BottomNavigationBar(
        currentIndex: 1,
        items: this.barItems,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
