import 'package:flutter/material.dart';
import 'package:advenza_project/widgets/bottom_navigation.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for three different notifications
    final notifications = [
      {
        'title': 'Your Booking is Confirmed',
        'message': 'Your booking to Disneyland Hong Kong is confirmed. Get ready for an amazing experience!',
        'date': '7 Jan',
        'image': 'assets/park-1.png',
      },
      {
        'title': 'New Offer Available!',
        'message': 'Special discounts are available for your next adventure. Don’t miss out!',
        'date': '5 Jan',
        'image': 'assests/offer.png',
      },
      {
        'title': 'Reminder: Trip Tomorrow',
        'message': 'Your trip to Disneyland is scheduled for tomorrow. Make sure you are packed and ready!',
        'date': '4 Jan',
        'image': 'assests/reminder.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assests/pofile.png'), // Replace with your image asset
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length, // Number of inbox items
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          notification['message']!,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Text(
                          notification['date']!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      notification['image']!, // Replace with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3),
    );
  }
}
