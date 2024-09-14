import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import '../../theme/theme.dart';
import 'admin-home.dart'; // Ensure you import the AdminHome page

class AddThemeParkScreen extends StatefulWidget {
  const AddThemeParkScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddThemeParkScreenState createState() => _AddThemeParkScreenState();
}

class _AddThemeParkScreenState extends State<AddThemeParkScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _imageLink1Controller = TextEditingController();
  final TextEditingController _imageLink2Controller = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Theme Park to Firestore
  Future<void> _addThemePark(BuildContext context) async {
    try {
      // Getting all the values
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final location = _locationController.text.trim();
      final imageLink1 = _imageLink1Controller.text.trim();
      final imageLink2 = _imageLink2Controller.text.trim();
      final price = double.tryParse(_priceController.text.trim());
      final rating = double.tryParse(_ratingController.text.trim());

      // Validate if the fields are filled
      if (name.isEmpty ||
          description.isEmpty ||
          location.isEmpty ||
          price == null ||
          rating == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill out all fields correctly.'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Add data to Firestore collection
      await _firestore.collection('theme_park').add({
        'park_name': name,
        'park_description': description,
        'park-location': location,
        'image-link-1': imageLink1,
        'image-link-2': imageLink2,
        'price': price,
        'rating': rating,
      });

      // Show success SnackBar and redirect to Admin Home
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Theme Park added successfully!'),
          backgroundColor: Color.fromARGB(255, 42, 88, 42),
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate to Admin Home after delay
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHome()));
    } catch (e) {
      // If there's an error, show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add theme park. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Theme Park', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Park Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Park Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Park Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _imageLink1Controller,
                decoration: const InputDecoration(
                  labelText: 'Image Link 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _imageLink2Controller,
                decoration: const InputDecoration(
                  labelText: 'Image Link 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addThemePark(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50), // Full width
                ),
                child: const Text('Add Park',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
