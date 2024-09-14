import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin-home.dart';

class AddNotificationPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  AddNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Notification",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 88, 42),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Title', titleController),
            const SizedBox(height: 16),
            _buildTextField('Body Text', descriptionController, maxLines: 5),
            const SizedBox(height: 16),
            _buildTextField('Image URL', imageController),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _sendNotification(context); // Pass the context
                },
                child: const Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 42, 88, 42),
                  padding: const EdgeInsets.symmetric(vertical: 16),
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

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
    );
  }

  void _sendNotification(BuildContext context) {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String imageUrl = imageController.text;
    final DateTime notificationTime = DateTime.now();

    if (title.isEmpty || imageUrl.isEmpty) {
      print('Title and image URL are required.');
      return;
    }

    FirebaseFirestore.instance.collection('notification').add({
      'title': title,
      'sub-text': description,
      'image-link': imageUrl,
      'time': notificationTime.toIso8601String(),
    }).then((_) {
      // Clear the text fields
      titleController.clear();
      descriptionController.clear();
      imageController.clear();

      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Notification sent successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 42, 88, 42),
        ),
      );

      // Navigate to AdminHome using Navigator.push
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()), // Replace AdminHome with your screen widget
        );
      });
    }).catchError((error) {
      print('Failed to send notification: $error');
      // Show error SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to send notification.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
