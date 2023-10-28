import 'package:flutter/material.dart';
import 'package:flutter_mini_project/providers/bottom_navigation_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});
  static const String route = '/myBottomNavigationBar';

  @override
  State<MyBottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<MyBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);

    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
          builder: (context, bottomProvider, _) {
        return bottomProvider.pages[bottomProvider.currentPageIndex];
      }),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Colors.amber,
        // color: Colors.white,
        // activeColor: Colors.white,
        // tabBackgroundColor: Colors.black,
        onTabChange: (value) {
          bottomNavigationProvider.changePages(value);
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.newspaper,
            text: 'News',
          ),
          GButton(
            icon: Icons.bookmark,
            text: 'Category',
          ),
        ],
      ),
    );
  }
}
