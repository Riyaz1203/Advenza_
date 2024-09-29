import 'package:advenza_project/screens/admin/add_notifiction.dart';
import 'package:advenza_project/screens/admin/add_rides.dart';
import 'package:advenza_project/screens/admin/add_theme_park.dart';
import 'package:advenza_project/screens/admin/approved_theme.dart';
import 'package:advenza_project/screens/admin/declined-park.dart';
import 'package:advenza_project/screens/admin/view-rides.dart';
import 'package:advenza_project/screens/admin/view-theme.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool showApprovedBadge = true; // Track notification for approved themes
  bool showDeclinedBadge = true; // Track notification for declined themes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const SizedBox(height: 20),
            Text('Quick Access Links', style: AppTheme.subHeadingStyle),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  // Existing Buttons
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddThemeParkScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Center(
                      child: Text('Add Theme Park',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddRidesPage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Center(
                      child: Text('Add Rides',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewThemeScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Center(
                      child: Text('View Theme Park',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewRidesScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Center(
                      child: Text('View Rides',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNotificationPage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Center(
                      child: Text('Send Notification',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20), // Gap before new buttons

                  // New Buttons for Approved and Declined Themes
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showApprovedBadge = false; // Hide badge when clicked
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApprovedTheme()),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight, // Changed to topRight
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showApprovedBadge =
                                  false; // Hide badge when clicked
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApprovedTheme()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Center(
                            child: Text('View Approved Themes',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        if (showApprovedBadge) // Show badge if true
                          Container(
                            margin: const EdgeInsets.only(
                                top: 0, right: 8), // Position the circle
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showDeclinedBadge = false; // Hide badge when clicked
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeclinedPark()),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight, // Changed to topRight
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showDeclinedBadge =
                                  false; // Hide badge when clicked
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeclinedPark()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Center(
                            child: Text('View Declined Themes',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        if (showDeclinedBadge) // Show badge if true
                          Container(
                            margin: const EdgeInsets.only(
                                top: 0, right: 8), // Position the circle
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
