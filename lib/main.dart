import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';
import 'state/joke_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokeState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        type: Transition.scale, // Transition effect
        durationInSeconds: 3, // Splash screen duration
        navigator: const HomePage(), // Proper navigation
        curve: Curves.easeInOut, // Animation curve
        backgroundColor: Colors.white, // Splash screen background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/laughing_image.jpg', // Path to your joke-related icon
              width: 160,
              height: 160,
            ),
            const SizedBox(height: 20),
            const Text(
              "Fetch-Jokes",
              style: TextStyle(
                fontSize: 44,
                fontFamily: 'LobsterTwo-Bold',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Get ready to laugh!",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'LobsterTwo-Bold',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
