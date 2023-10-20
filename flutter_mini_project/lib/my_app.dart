import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/bottom_navigation.dart';
import 'package:flutter_mini_project/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      ),
      home: const MyBottomNavigation(),
    );
  }
}
