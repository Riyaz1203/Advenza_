import 'dart:math'; // Import for random number generation
import 'package:advenza_project/screens/users/payment-succesfull.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  PaymentPage({super.key, required this.bookingData});

  // Function to generate random ticket price
  int _generateRandomPrice() {
    final random = Random();
    return random.nextInt(8001) + 8000; // Random price between 8000 and 16000
  }

  // Function to generate random flight charges
  int _generateRandomFlightCharges() {
    final random = Random();
    return random.nextInt(50000) +
        10000; // Random flight charges between 10000 and 60000
  }

  @override
  Widget build(BuildContext context) {
    // Generate random values
    String dateOfVisit = bookingData['date_of_visit'] ??
        "Monday ${Random().nextInt(30) + 1}th Aug 2024";
    String ticketType = bookingData['ticket_type'] ??
        (Random().nextBool() ? "Single-day Ticket" : "Two-day Ticket");
    int ticketPrice = _generateRandomPrice();
    int boardingPassCharge = _generateRandomFlightCharges();
    int convenienceFees = 1650;
    int total = boardingPassCharge +
        convenienceFees +
        (Random().nextBool() ? 10000 : 0); // Adding flight insurance randomly

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Price"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.airplane_ticket, size: 30),
                        SizedBox(width: 10),
                        Text(
                          "Tickets",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(dateOfVisit),
                    const SizedBox(height: 8),
                    Text(ticketType),
                    const SizedBox(height: 8),
                    Text("INR ₹$ticketPrice"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flight Booking Charges",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.info_outline),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Type:"),
                        Text("Round Trip"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Boarding Pass:"),
                        Text("₹$boardingPassCharge"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Convenience Fees:"),
                        Text("₹1650"),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total:"),
                        Text("₹$total"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                            value: Random().nextBool(), onChanged: (value) {}),
                        const Text("Flight Insurance +₹10,000"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketsBookedPage()),
                  );
                },
                child: const Text(
                  "Proceed to Pay",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 42, 88, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
