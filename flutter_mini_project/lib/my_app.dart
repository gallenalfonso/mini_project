import 'package:flutter/material.dart';
import 'package:flutter_mini_project/viewmodel/providers/bottom_navigation_provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/get_financial_planner_provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/homepage_provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/news_provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/transaction_screen_provider.dart';
import 'package:flutter_mini_project/view/screens/bottom_navigation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomepageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetFinancialPlannerProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Tracker',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: AppBarTheme(color: Colors.teal[300]),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.amber, // Warna tombol aktif
            disabledColor: Colors.grey, // Warna tombol saat dinonaktifkan
            // Atur properti lain sesuai kebutuhan Anda
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor:
                Colors.amber[100], // Background color of the floating action button
            foregroundColor:
                Colors.black, // Text/icon color of the floating action button
          ),
        ),
        home: const MyBottomNavigation(),
      ),
    );
  }
}
