import 'package:advenza_project/screens/users/payment-succesfull.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  PaymentPage({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    // Retrieve ticket price from bookingData and convert it to an integer
    final int ticketPrice =
        (bookingData['price'] ?? 0.0).toInt(); // Convert double to int

    // Parse the number of adults and children
    int numberOfAdults =
        int.tryParse(bookingData['number_of_adults'].toString()) ??
            0; // Use toString() to handle any potential null values
    int numberOfChildren =
        int.tryParse(bookingData['number_of_children'].toString()) ?? 0;

    // Calculate total ticket price
    int totalTicketPrice = (numberOfAdults + numberOfChildren) * ticketPrice;

    // Other charges
    int convenienceFees = 1650;
    int total = totalTicketPrice +
        convenienceFees; // Total includes ticket price and convenience fees

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display total price at the top
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
                        Icon(Icons.attach_money,
                            size: 30), // Changed icon for money
                        SizedBox(width: 10),
                        Text(
                          "Total Price",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Show detailed ticket price calculation
                    Text(
                      "Total Ticket Price: INR ₹${ticketPrice} x ($numberOfAdults + $numberOfChildren) = ₹$totalTicketPrice",
                    ),
                    const SizedBox(height: 8),
                    Text("Convenience Fees: INR ₹$convenienceFees"),
                    const SizedBox(height: 8),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Grand Total:"),
                        Text("₹$total",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display ticket information
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
                    Text("Number of Adults: $numberOfAdults"),
                    const SizedBox(height: 8),
                    Text("Number of Children: $numberOfChildren"),
                    const SizedBox(height: 8),
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
