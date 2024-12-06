
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entrydisplay/third_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SmoothPageRoute(page: const Thirdpage()),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFA726), // Orange top gradient
                Color(0xFFFFCC80), // Light orange bottom gradient
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon resembling a pagoda
                Image.asset(
                  'assets/image/temple_icon.png', // Replace with your asset path
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                // "Histoury" text
                const Text(
                  'Histoury',
                  style: TextStyle(
                    fontFamily: 'Roboto', // Adjust this to your preferred font
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
