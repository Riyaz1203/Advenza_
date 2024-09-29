import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/view-rides.dart'; // Ensure ApproveCard is defined here or imported

class ViewThemeScreen extends StatelessWidget {
  const ViewThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Theme Park',
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
          stream:
              FirebaseFirestore.instance.collection('theme_park').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No rides available.'));
            }

            final themeParks = snapshot.data!.docs.map<Widget>((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // Extract data safely with fallback values
              final double price =
                  double.tryParse(data['price'].toString()) ?? 0.0;
              final String imageUrl =
                  data['image-link-1'] ?? 'https://via.placeholder.com/200';

              // Pass the document ID and other fields to ApproveCard
              return ApproveCard(
                docId: doc.id, // Pass the document ID
                parkName: data['park_name'] ?? 'Unknown Park',
                location: data['park-location'] ?? 'Unknown Location',
                price: price,
                imageUrl: imageUrl,
                description: data['description'] ?? 'No Description', // Ensure to add a description
                imageLink1: imageUrl, // You may replace this with another image if available
                imageLink2: '', // Replace with actual second image if available
                rating: data['rating'] != null ? double.tryParse(data['rating'].toString()) ?? 0.0 : 0.0, // Adjust as necessary
              );
            }).toList(); // Ensure that this is a List<Widget>

            return ListView(
              children: themeParks,
            );
          },
        ),
      ),
    );
  }
}
