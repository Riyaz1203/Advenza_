import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/view-rides.dart';

class ApproveRidesScreen extends StatelessWidget {
  const ApproveRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Rides', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('theme_rides').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No rides available.'));
            }

            final themeParks = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Safely extract 'price' and 'imageUrl', and use placeholder values if necessary
              final double price =
                  double.tryParse(data['price'].toString()) ?? 0.0;
              final String imageUrl =
                  data['image-link-1'] ?? 'https://via.placeholder.com/200';

              return ApproveCard(
                parkName: data['ride_name'] ?? 'Unknown Park',
                location: data['ride-location'] ?? 'Unknown Location',
                price: price,
                imageUrl: imageUrl, // Pass image URL to RideCard
              );
            }).toList();

            return ListView(
              children: themeParks,
            );
          },
        ),
      ),
    );
  }
}
