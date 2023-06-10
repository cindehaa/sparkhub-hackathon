import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final Function(int value) changeScreen;
  const Navbar({super.key, required this.changeScreen});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedState = 1;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedState,
      groupAlignment: -1,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (int index) {
        if (index != _selectedState) {
          widget.changeScreen(index);
          setState(() {
            _selectedState = index;
          });
        }
      },
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
