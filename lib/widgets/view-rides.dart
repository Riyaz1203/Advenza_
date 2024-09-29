import 'package:advenza_project/screens/admin/edit-theme-park-screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import '../../theme/theme.dart';

class ApproveCard extends StatelessWidget {
  final String parkName;
  final String location;
  final double price;
  final String imageUrl; // Add image URL field
  final String docId; // Add docId field
  final String description; // Add description field
  final String imageLink1; // Add first image link
  final String imageLink2; // Add second image link
  final double rating; // Add rating field

  ApproveCard({
    required this.parkName,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.docId, // Required docId
    required this.description, // Required description
    required this.imageLink1, // Required first image link
    required this.imageLink2, // Required second image link
    required this.rating, // Required rating
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image at the top
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200, // Adjust the height as needed
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parkName, style: AppTheme.headingStyle),
                SizedBox(height: 8),
                Text(location, style: AppTheme.bodyTextStyle),
                SizedBox(height: 10),
                Text('\Rs:$price per ticket', style: AppTheme.bodyTextStyle),
                SizedBox(height: 20),
                // Edit and Delete buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to edit screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditThemeParkScreen(
                              docId: docId, // Pass the document ID
                              parkName: parkName,
                              description: description,
                              location: location,
                              imageLink1: imageLink1,
                              imageLink2: imageLink2,
                              price: price,
                              rating: rating,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 42, 88, 42), // Edit button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child:
                          Text('Edit', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Show confirmation dialog before deleting
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete $parkName?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Delete the park from Firestore
                                    await FirebaseFirestore.instance
                                        .collection('theme_park')
                                        .doc(docId)
                                        .delete();

                                    // Show a SnackBar after successful deletion
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '$parkName deleted successfully',
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 42, 88, 42),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Delete button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
