import 'package:advenza_project/screens/users/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../theme/theme.dart';

class TicketsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user UID
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tickets'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('booked-tickets')
            .doc(userId) // Get document by UID
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No tickets found.'));
          }

          // Data exists
          var ticketData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ticket Image

                  // Scan Barcode Instruction
                  Column(
                    children: [
                      Text(
                        'Scan Your Ticket Barcode Below',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        Icons.qr_code_scanner,
                        size: 50,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Barcode Image
                  Image.asset(
                    'assests/ticket.png', // Corrected path for barcode image
                    height: 100,
                  ),
                  const SizedBox(height: 20),

                  // Ticket Details Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title for Ticket Details
                          Text(
                            'Ticket Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(), // Divider for separation

                          // Ticket Details
                          _buildDetailRow('Park Name', ticketData['park_name']),
                          _buildDetailRow(
                              'Ticket Type', ticketData['ticket_type']),
                          _buildDetailRow('Number of Adults',
                              ticketData['number_of_adults']),
                          _buildDetailRow('Number of Children',
                              ticketData['number_of_children']),
                          _buildDetailRow('Full Name', ticketData['full_name']),
                          _buildDetailRow('Email', ticketData['email']),
                          _buildDetailRow(
                              'Date of Visit', ticketData['date_of_visit']),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Return Home Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExplorePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 80),
                    ),
                    child: const Text('Return Home',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value?.toString() ?? 'N/A',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
