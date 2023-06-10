import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedState = 1;
  String pageState = "BUY";

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedState,
      onDestinationSelected: (int index) {
        switch (_selectedState) {
          case 0:
            pageState = "PROFILE";
            break;
          case 1:
            pageState = "BUY";
            break;
          case 2:
            pageState = "CREATE";
        }
        setState(() {
          _selectedState = index;
        });
      },
      groupAlignment: -1,
      labelType: NavigationRailLabelType.all,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: Text('Profile'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.shop_2_outlined),
          selectedIcon: Icon(Icons.shop_2),
          label: Text('Buy'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.add_box_outlined),
          selectedIcon: Icon(Icons.add_box),
          label: Text('Create Listing'),
        ),
      ],
    );
  }
}
