import 'package:flutter/material.dart';
import 'package:advenza_project/widgets/navbar.dart'; // Import the NavBar widget
import 'package:advenza_project/screens/users/profile_page.dart';

import '../../widgets/bottom_navigation.dart'; // Profile page

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
                  AssetImage('assests/pofile.png'), // Correct asset path
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: NavBar(), // Use your custom NavBar widget inside the Drawer
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Advenza, your gateway to a world of fun and adventure at Amusement Park. Discover a place where thrills, entertainment, and unforgettable memories await. Whether you\'re here for the heart-pounding rides, family-friendly attractions, or a day full of excitement, we\'ve got something for everyone. Start exploring now and make the most of your visit!',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            _buildFeaturedAttractionsSection(),
            const SizedBox(height: 20),
            _buildPromotionsSection(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  // Featured Attractions Section
  Widget _buildFeaturedAttractionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Attractions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assests/map.png', // Corrected to 'assets'
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Experience the ultimate adrenaline rush on our most popular roller coaster.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Promotions Section
  Widget _buildPromotionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Promotions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assests/offer.png', // Corrected asset path
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Enjoy up to 25% off on all water park tickets this summer.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
