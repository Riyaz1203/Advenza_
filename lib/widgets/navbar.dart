import 'package:advenza_project/screens/admin/view-theme.dart';
import 'package:advenza_project/screens/users/Notification_inbox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth for sign out
import 'package:advenza_project/screens/users/profile_page.dart';

import '../auth/api.dart';
import '../screens/users/get_started.dart'; // Import your Profile page
// Import your Auth class

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 42, 88, 42), // Green background
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 42, 88, 42), // Green background
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Advenza',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
            // Notifications
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.white),
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.white), // White text
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InboxPage(),
                  ),
                );
              },
            ),
            // Profile
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'My Profile',
                style: TextStyle(color: Colors.white), // White text
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            // View Parks
            ListTile(
              leading: const Icon(Icons.park, color: Colors.white),
              title: const Text(
                'View Parks',
                style: TextStyle(color: Colors.white), // White text
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewThemeScreen(),
                  ),
                );
              },
            ),
            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white), // White text
              ),
              onTap: () async {
                Auth auth = Auth(); // Initialize your Auth class

                await auth.signOut(); // Sign out the user

                // Navigate to the Get Started page after logging out
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetStartedPage(),
                  ),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
