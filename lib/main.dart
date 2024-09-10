import 'package:advenza_project/screens/Notification_inbox.dart';
import 'package:advenza_project/screens/add_discount.dart';
import 'package:advenza_project/screens/add_notifiction.dart';
import 'package:advenza_project/screens/add_rides.dart';
import 'package:advenza_project/screens/book-elplore.dart';
import 'package:advenza_project/screens/book_tiicket_page.dart';
import 'package:advenza_project/screens/explore_page.dart';
import 'package:advenza_project/screens/get_started.dart';
import 'package:advenza_project/screens/home_page.dart';
import 'package:advenza_project/screens/pre-payment.dart';
import 'package:advenza_project/screens/profile_page.dart';
import 'package:advenza_project/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        '/explore': (context) => ExplorePage(),
        '/wishlist': (context) => const SearchPage(),
      },
      home: AddNotificationPage(),
    );
  }
}
