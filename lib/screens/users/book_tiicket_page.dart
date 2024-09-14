import 'package:advenza_project/screens/users/ticket-booked.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookTicketsPage extends StatefulWidget {
  final Map<String, dynamic> parkData;

  const BookTicketsPage({super.key, required this.parkData});

  @override
  _BookTicketsPageState createState() => _BookTicketsPageState();
}

class _BookTicketsPageState extends State<BookTicketsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfVisitController = TextEditingController();
  final TextEditingController _numberOfAdultsController =
      TextEditingController();
  final TextEditingController _numberOfChildrenController =
      TextEditingController();
  String _selectedTicketType = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Tickets"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Make children stretch to full width
            children: [
              // Display the park image at the top
              Container(
                width: double.infinity,
                height: 200, // Set a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.parkData['image-link-1'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  widget.parkData['park_name'] ?? 'No Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 42, 88, 42),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Personal Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your full name'
                          : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your email address'
                          : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your phone number'
                          : null,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Ticket Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _dateOfVisitController,
                      decoration: InputDecoration(
                        labelText: "Date of Visit",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter the date of visit'
                          : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _numberOfAdultsController,
                      decoration: InputDecoration(
                        labelText: "Number of Adults",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter the number of adults'
                          : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _numberOfChildrenController,
                      decoration: InputDecoration(
                        labelText: "Number of Children",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter the number of children'
                          : null,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedTicketType,
                      decoration: InputDecoration(
                        labelText: "Select Ticket Type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(value: "None", child: Text("None")),
                        DropdownMenuItem(
                            value: "Single-day", child: Text("Single-day")),
                        DropdownMenuItem(
                            value: "Multi-day", child: Text("Multi-day")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedTicketType = value ?? "None";
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity, // Make the button full-width
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              try {
                                final bookingDetails = {
                                  'park_name': widget.parkData['park_name'],
                                  'park_location':
                                      widget.parkData['park-location'],
                                  'park_description':
                                      widget.parkData['park_description'],
                                  'price': widget.parkData['price'],
                                  'rating': widget.parkData['rating'],
                                  'duration': widget.parkData['duration'],
                                  'image-link-1':
                                      widget.parkData['image-link-1'],
                                  'full_name': _fullNameController.text,
                                  'email': _emailController.text,
                                  'phone_number': _phoneController.text,
                                  'date_of_visit': _dateOfVisitController.text,
                                  'number_of_adults':
                                      _numberOfAdultsController.text,
                                  'number_of_children':
                                      _numberOfChildrenController.text,
                                  'ticket_type': _selectedTicketType,
                                };

                                await FirebaseFirestore.instance
                                    .collection('booked-tickets')
                                    .doc(user.uid)
                                    .set(bookingDetails);

                                // Navigate to the success page with the booking data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmTicketsScreen(
                                        bookingData: bookingDetails),
                                  ),
                                );
                              } catch (e) {
                                print('Error booking tickets: $e');
                              }
                            }
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor:
                              const Color.fromARGB(255, 42, 88, 42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
