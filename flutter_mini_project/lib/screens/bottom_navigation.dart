import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/category_screen.dart';
import 'package:flutter_mini_project/screens/home_page.dart';
import 'package:flutter_mini_project/screens/news_screen.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});
  static const String route = '/myBottomNavigationBar';

  @override
  State<MyBottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<MyBottomNavigation> {
  final List<Widget> pages = [
    const HomePage(),
    const NewsScreen(),
    const CategoryScreen(),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Category',
          ),
        ],
      ),
    );
  }
}
