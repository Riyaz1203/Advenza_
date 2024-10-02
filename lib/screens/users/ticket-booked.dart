import 'package:flutter/material.dart';
import 'package:advenza_project/screens/users/explore_page.dart'; // Import ExplorePage
import 'package:advenza_project/screens/users/pre-payment.dart';
import 'package:advenza_project/theme/theme.dart';

class ConfirmTicketsScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const ConfirmTicketsScreen({super.key, required this.bookingData, required Map<String, dynamic> bookingDetails});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When system back button is pressed, navigate to ExplorePage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ExplorePage()),
          (route) => false, // This removes all previous routes
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text('Your Tickets', style: TextStyle(color: Colors.white)),
          backgroundColor: AppTheme.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
                (route) => false,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Display park image at the top
                Image.network(
                  bookingData['image-link-1'] ??
                      'https://example.com/default_image.jpg', // Use a default image if not available
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookingData['park_name'] ?? 'Park Name',
                          style: AppTheme.headingStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Date of Visit: ${bookingData['date_of_visit'] ?? 'Unknown Date'}',
                          style: AppTheme.bodyTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Number of Adults: ${bookingData['number_of_adults'] ?? '0'}',
                          style: AppTheme.bodyTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Number of Children: ${bookingData['number_of_children'] ?? '0'}',
                          style: AppTheme.bodyTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Ticket Type: ${bookingData['ticket_type'] ?? 'None'}',
                          style: AppTheme.bodyTextStyle,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Flight Information',
                                style: AppTheme.headingStyle),
                            Icon(Icons.flight_takeoff,
                                color: AppTheme.primaryColor),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // You might want to replace this with actual flight data if available
                          'Flight: ${bookingData['flight_info'] ?? 'No flight information available'}\nDate & Time: ${bookingData['flight_date_time'] ?? 'Not specified'}',
                          style: AppTheme.bodyTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Show feedback before navigating
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Proceeding to payment...'),
                        backgroundColor: Color.fromARGB(255, 42, 88, 42),
                      ),
                    );
                    // Pass bookingData when navigating to PaymentPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentPage(bookingData: bookingData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 80),
                  ),
                  child: const Text('Make Payment',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
