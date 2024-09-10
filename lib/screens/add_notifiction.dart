import 'package:flutter/material.dart';

class AddNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Notification"),
        leading: Icon(Icons.arrow_back),
        actions: [
          Image.asset(
            'assests/pofile.png', // Replace with your profile image asset
            fit: BoxFit.cover,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Title'),
            SizedBox(height: 16),
            _buildTextField('Body Text (Optional)', maxLines: 5),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconWithLabel(Icons.link, "Insert Uri"),
                _buildIconWithLabel(Icons.attach_file, "Attach Image"),
                _buildIconWithLabel(Icons.poll, "Add Poll"),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 42, 88, 42),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage:
                    AssetImage('assests/pofile.png'), // Profile picture
              ),
              label: ""),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
