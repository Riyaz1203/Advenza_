import 'package:advenza_project/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADVENZA'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Add your menu action here
          },
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assests/pofile.png', // Corrected to AssetImage for local image
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Advenza, your gateway to a world of fun and adventure at Amusement Park . Discover a place where thrills, entertainment, and unforgettable memories await. Whether youre here for the heart-pounding rides, family-friendly attractions, or a day full of excitement, we ve got something for everyone. Start exploring now and make the most of your visit!',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            // Featured Attractions Section
            _buildFeaturedAttractionsSection(),
            SizedBox(height: 20),
            // Promotions Section
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Attractions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assests/map.png', // Corrected to Image.asset for local image
                width: 80,
                height: 80,
              ),
              SizedBox(width: 10),
              Expanded(
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promotions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assests/offer.png', // Corrected to Image.asset for local image
                width: 80,
                height: 80,
              ),
              SizedBox(width: 10),
              Expanded(
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
