import 'package:flutter/material.dart';
import 'package:flutter_mini_project/viewmodel/providers/bottom_navigation_provider.dart';
import 'package:flutter_mini_project/view/screens/transaction_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TransactionScreen(),
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add_sharp),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: GNav(
        gap: 5,
        backgroundColor: Colors.white,
        color: Colors.black,
        activeColor: Colors.black,
        tabBackgroundColor: Colors.white,
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
            icon: Icons.auto_awesome,
            text: 'Planner',
          ),
          GButton(
            icon: Icons.data_thresholding,
            text: 'Charts',
          ),
        ],
      ),
    );
  }
}
