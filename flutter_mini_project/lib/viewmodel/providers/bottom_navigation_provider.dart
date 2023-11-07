import 'package:flutter/material.dart';

import 'package:flutter_mini_project/view/screens/get_financial_planner_screen.dart';
import 'package:flutter_mini_project/view/screens/home_page.dart';
import 'package:flutter_mini_project/view/screens/news_screen.dart';
import 'package:flutter_mini_project/view/screens/pie_chart.dart';

class BottomNavigationProvider extends ChangeNotifier {
  final List<Widget> pages = [
    const HomePage(),
    const NewsScreen(),
    const GetFinancialPlannerScreen(),
    const ShowCharts()
  ];

  int currentPageIndex = 0;

  void changePages( value) {
    currentPageIndex = value;
    notifyListeners(); 
  }
}
