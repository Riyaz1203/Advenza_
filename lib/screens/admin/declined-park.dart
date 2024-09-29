import 'package:advenza_project/widgets/declined-card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class DeclinedPark extends StatelessWidget {
  const DeclinedPark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Declined Theme Parks',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('declined-park') // Ensure collection name is correct
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text('No declined theme parks available.'));
            }

            final themeParks = snapshot.data!.docs.map<Widget>((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Safely extract values and ensure fallback defaults
              final double price =
                  double.tryParse(data['price'].toString()) ?? 0.0;
              final String imageUrl =
                  data['image-link-1'] ?? 'https://via.placeholder.com/200';

              // Pass the document fields to DeclinedParkCard
              return DeclinedParkCard(
                parkName: data['park_name'] ?? 'Unknown Park',
                location: data['park-location'] ?? 'Unknown Location',
                price: price,
                imageUrl: imageUrl,
                description: data['park_description'] ?? 'No Description',
                rating: data['rating'] != null
                    ? double.tryParse(data['rating'].toString()) ?? 0.0
                    : 0.0, // Rating
              );
            }).toList(); // Ensure it is a List<Widget>

            return ListView(
              children: themeParks,
            );
          },
        ),
      ),
    );
  }
}
