import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        // Handle navigation based on the index tapped
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/explore');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/wishlist');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/alerts');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_heart_rounded),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
      ],
      selectedItemColor: Colors.black, // Color for the selected item
      unselectedItemColor: Colors.black, // Color for the unselected items
    );
  }
}
