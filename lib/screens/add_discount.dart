import 'package:flutter/material.dart';

class AddDiscountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Discount"),
        leading: Icon(Icons.arrow_back),
        actions: [
          Image.asset(
            'assests/pofile.png', // Replace with your profile image asset
            fit: BoxFit.cover,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Event Name'),
              SizedBox(height: 16),
              _buildTextField('Event Description'),
              SizedBox(height: 16),
              _buildTextField('Event Category'),
              SizedBox(height: 16),
              _buildTextField('Target Audience'),
              SizedBox(height: 16),
              _buildTextField('Discount Percentage'),
              SizedBox(height: 16),
              _buildTextField('Event Price (Finalized)'),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Add Discount",
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
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(labelText: label),
    );
  }
}
