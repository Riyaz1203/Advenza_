import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ApprovedParkCard extends StatelessWidget {
  final String parkName;
  final String location;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;

  ApprovedParkCard({
    required this.parkName,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5, // Add shadow for card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image at the top
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200, // Adjust the height as needed
            ),
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
                SizedBox(height: 8),
                Text('Rating: $rating', style: AppTheme.bodyTextStyle),
                SizedBox(height: 8),
                Text('Description: $description',
                    style: AppTheme.bodyTextStyle),
                SizedBox(height: 20),
                // Custom Approved Message
                Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.green.withOpacity(0.1), // Light green background
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(
                        color: Colors.green, width: 1), // Green border
                  ),
                  padding: EdgeInsets.all(12), // Padding inside the container
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Your park has been successfully approved!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
