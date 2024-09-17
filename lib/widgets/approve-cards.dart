import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ApproveCards extends StatelessWidget {
  final String parkName;
  final String location;
  final double price;
  final String imageUrl; // Add image URL field

  ApproveCards({
    required this.parkName,
    required this.location,
    required this.price,
    required this.imageUrl,
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
                Text('\$$price per ticket', style: AppTheme.bodyTextStyle),
                SizedBox(height: 20),
                // Edit and Delete buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Edit functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 42, 88, 42), // Edit button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text('Approve',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Delete functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Delete button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text('Decline',
                          style: TextStyle(color: Colors.white)),
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
