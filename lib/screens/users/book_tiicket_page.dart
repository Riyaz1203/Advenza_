import 'package:advenza_project/screens/users/ticket-booked.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfVisitController.text =
            DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Tickets"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.parkData['image-link-1'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.parkData['park_name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 42, 88, 42),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Personal Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Phone number must be exactly 10 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Ticket Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dateOfVisitController,
                          decoration: InputDecoration(
                            labelText: "Date of Visit",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter the date of visit';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedTicketType,
                      decoration: InputDecoration(
                        labelText: "Select Ticket Type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
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

                                // Save the booking data to Firestore
                                await FirebaseFirestore.instance
                                    .collection('booked-tickets')
                                    .doc(user.uid)
                                    .set(bookingDetails);

                                // Clear all form fields
                                _fullNameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
                                _dateOfVisitController.clear();
                                _numberOfAdultsController.clear();
                                _numberOfChildrenController.clear();
                                setState(() {
                                  _selectedTicketType = "None";
                                });

                                // Navigate to ConfirmTicketsScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmTicketsScreen(
                                      bookingData: bookingDetails,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                print('Error booking tickets: $e');
                              }
                            }
                          } else {
                            // Show a SnackBar if validation fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please correct the errors in the form'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
