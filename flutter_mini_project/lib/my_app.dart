import 'package:flutter/material.dart';
import 'package:flutter_mini_project/providers/bottom_navigation_provider.dart';
import 'package:flutter_mini_project/providers/news_provider.dart';
import 'package:flutter_mini_project/screens/bottom_navigation.dart';
import 'package:flutter_mini_project/screens/home_page.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Tracker',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.amber, // Warna tombol aktif
            disabledColor: Colors.grey, // Warna tombol saat dinonaktifkan
            // Atur properti lain sesuai kebutuhan Anda
          ),
        ),
        home: const MyBottomNavigation(),
      ),
    );
  }
}
