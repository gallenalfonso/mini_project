import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/category_screen.dart';
import 'package:flutter_mini_project/screens/home_page.dart';
import 'package:flutter_mini_project/screens/news_screen.dart';

class BottomNavigationProvider extends ChangeNotifier {
  final List<Widget> pages = [
    const HomePage(),
    const NewsScreen(),
    const CategoryScreen(),
  ];

  int currentPageIndex = 0;

  void changePages( value) {
    currentPageIndex = value;
    notifyListeners(); 
  }
}
