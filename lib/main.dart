import 'package:advenza_project/screens/admin/admin-home.dart';
import 'package:advenza_project/screens/admin/admin-main-home.dart';
import 'package:advenza_project/screens/admin/approved_theme.dart';
import 'package:advenza_project/screens/admin/declined-park.dart';
import 'package:advenza_project/screens/users/Notification_inbox.dart';
import 'package:advenza_project/screens/users/book_tiicket_page.dart';
import 'package:advenza_project/screens/users/explore_page.dart';
import 'package:advenza_project/screens/users/get_started.dart';
import 'package:advenza_project/screens/users/home_page.dart';
import 'package:advenza_project/screens/users/search_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/users/profile_page.dart';

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
        '/explore': (context) => const ExplorePage(),
        '/wishlist': (context) => const SearchPage(),
        '/inbox': (context) => const InboxPage(),
        '/getstarted': (context) => const GetStartedPage(),
      },
      home: GetStartedPage(),
    );
  }
}
