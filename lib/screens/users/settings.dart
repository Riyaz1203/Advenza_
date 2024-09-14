import 'package:advenza_project/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTheme.headingStyle),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user_avatar.png'), // Use a local image asset
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Notifications', style: AppTheme.subHeadingStyle),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Reset data function
              },
              child: Text(
                'Reset Data',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Delete account function
              },
              child: Text(
                'Delete My Account',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
