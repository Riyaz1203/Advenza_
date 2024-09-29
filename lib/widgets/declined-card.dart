import 'package:flutter/material.dart';
import '../theme/theme.dart';

class DeclinedParkCard extends StatelessWidget {
  final String parkName;
  final String location;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;

  DeclinedParkCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image at the top
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
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
                Text('Description: $description', style: AppTheme.bodyTextStyle),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Your park has been declined. Sorry!',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
