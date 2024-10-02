import 'package:flutter/material.dart';
import 'package:advenza_project/widgets/navbar.dart';
import 'package:advenza_project/screens/users/profile_page.dart';
import '../../widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADVENZA'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: const CircleAvatar(
              backgroundImage:
                  AssetImage('assests/pofile.png'), // Keep asset path unchanged
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: NavBar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assests/INTRO.jpg', // Keep image asset path unchanged
                width: 400,
                height: 400,
              ),
              const Text(
                'Welcome to Advenza', // Display "Welcome to Advenza" in bold
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 10), // Add space between title and paragraph
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your gateway to a world of fun and adventure at Amusement Park. Discover a place where thrills, entertainment, and unforgettable memories await. Whether you\'re here for the heart-pounding rides, family-friendly attractions, or a day full of excitement, we\'ve got something for everyone. Start exploring now and make the most of your visit!',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
