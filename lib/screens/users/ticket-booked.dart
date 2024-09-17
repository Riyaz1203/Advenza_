import 'package:advenza_project/screens/users/pre-payment.dart';
import 'package:flutter/material.dart';
import 'package:advenza_project/theme/theme.dart';

class ConfirmTicketsScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const ConfirmTicketsScreen({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tickets', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
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
                    '', // Use the image URL from bookingData
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
                      // Park name
                      Text(
                        bookingData['park_name'] ?? 'Park Name',
                        style: AppTheme.headingStyle,
                      ),
                      const SizedBox(height: 10),
                      // Date of Visit
                      Text(
                        'Date of Visit: ${bookingData['date_of_visit'] ?? 'Unknown Date'}',
                        style: AppTheme.bodyTextStyle,
                      ),
                      const SizedBox(height: 10),
                      // Number of Adults
                      Text(
                        'Number of Adults: ${bookingData['number_of_adults'] ?? '0'}',
                        style: AppTheme.bodyTextStyle,
                      ),
                      const SizedBox(height: 10),
                      // Number of Children
                      Text(
                        'Number of Children: ${bookingData['number_of_children'] ?? '0'}',
                        style: AppTheme.bodyTextStyle,
                      ),
                      const SizedBox(height: 10),
                      // Ticket Type
                      Text(
                        'Ticket Type: ${bookingData['ticket_type'] ?? 'None'}',
                        style: AppTheme.bodyTextStyle,
                      ),
                      const SizedBox(height: 20),
                      // Additional details
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
                        'Example Flight Info\nDate & Time',
                        style: AppTheme.bodyTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Ticket confirmation image
                      Image.asset(
                        'assests/pofile.png', // Replace with a barcode image if available
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                ),
                child:
                    Text('Make Payment', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
