import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/theme.dart';
import 'admin-home.dart'; // Ensure you import the AdminHome page

class EditThemeParkScreen extends StatefulWidget {
  final String docId; // Document ID to update
  final String parkName;
  final String description;
  final String location;
  final String imageLink1;
  final String imageLink2;
  final double price;
  final double rating;

  const EditThemeParkScreen({
    Key? key,
    required this.docId,
    required this.parkName,
    required this.description,
    required this.location,
    required this.imageLink1,
    required this.imageLink2,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  _EditThemeParkScreenState createState() => _EditThemeParkScreenState();
}

class _EditThemeParkScreenState extends State<EditThemeParkScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _imageLink1Controller = TextEditingController();
  final TextEditingController _imageLink2Controller = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with the existing values
    _nameController.text = widget.parkName;
    _descriptionController.text = widget.description;
    _locationController.text = widget.location;
    _imageLink1Controller.text = widget.imageLink1;
    _imageLink2Controller.text = widget.imageLink2;
    _priceController.text = widget.price.toString();
    _ratingController.text = widget.rating.toString();
  }

  // Update Theme Park in Firestore
  Future<void> _updateThemePark(BuildContext context) async {
    try {
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();
      final location = _locationController.text.trim();
      final imageLink1 = _imageLink1Controller.text.trim();
      final imageLink2 = _imageLink2Controller.text.trim();
      final price = double.tryParse(_priceController.text.trim());
      final rating = double.tryParse(_ratingController.text.trim());

      if (name.isEmpty || description.isEmpty || location.isEmpty || price == null || rating == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill out all fields correctly.'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Update data in Firestore
      await FirebaseFirestore.instance.collection('theme_park').doc(widget.docId).update({
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
          content: Text('Theme Park updated successfully!'),
          backgroundColor: Color.fromARGB(255, 42, 88, 42),
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate to Admin Home after delay
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHome()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update theme park. Please try again.'),
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
        title: const Text('Edit Theme Park', style: TextStyle(color: Colors.white)),
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
                onPressed: () => _updateThemePark(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50), // Full width
                ),
                child: const Text('Update Park', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
