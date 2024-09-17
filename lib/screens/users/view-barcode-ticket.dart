import 'package:advenza_project/screens/users/explore_page.dart';
import 'package:advenza_project/screens/users/pre-payment.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class TicketsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ticket Image (Replace with the actual image path)
              Image.asset(
                'assests/ticket.png',
                height: 150,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 20),
              // Barcode Image (Replace with the actual image path)
              Image.asset(
                'assests/Tickets.png',
                height: 450,
              ),
              const SizedBox(height: 20),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                ),
                child: const Text('Return Home',
                    style: TextStyle(color: Colors.white)),
              )

              // Save button
            ],
          ),
        ),
      ),
    );
  }
}
