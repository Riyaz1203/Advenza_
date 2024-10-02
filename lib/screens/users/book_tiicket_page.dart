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

  // New fields
  final TextEditingController _visitorNameController = TextEditingController();
  final TextEditingController _visitorAgeController = TextEditingController();
  final TextEditingController _visitorEmailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  bool _agreementChecked = false;
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

                    // Visitor Information
                    const SizedBox(height: 20),
                    const Text(
                      "Visitor Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _visitorNameController,
                      decoration: InputDecoration(
                        labelText: "Visitor Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter visitor name'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _visitorAgeController,
                      decoration: InputDecoration(
                        labelText: "Visitor Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter visitor age'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _visitorEmailController,
                      decoration: InputDecoration(
                        labelText: "Visitor Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter visitor email'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Payment Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter card number';
                        } else if (!RegExp(r'^\d{16}$').hasMatch(value)) {
                          return 'Card number must be 16 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        } else if (!RegExp(r'^\d{3}$').hasMatch(value)) {
                          return 'CVV must be 3 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        labelText: "Expiration Date (MM/YY)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiration date';
                        } else if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                            .hasMatch(value)) {
                          return 'Expiration date must be in MM/YY format';
                        }
                        return null;
                      },
                    ),

                    // Agreement and Terms
                    const SizedBox(height: 20),
                    const Text(
                      "Additional Options",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreementChecked,
                          onChanged: (value) {
                            setState(() {
                              _agreementChecked = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "Genie + Service",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreementChecked,
                          onChanged: (value) {
                            setState(() {
                              _agreementChecked = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "Parking",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreementChecked,
                          onChanged: (value) {
                            setState(() {
                              _agreementChecked = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "Dining Reservation",
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Terms and Condition",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreementChecked,
                          onChanged: (value) {
                            setState(() {
                              _agreementChecked = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "I agree to the terms and conditions",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
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
                                'image-link-1': widget.parkData['image-link-1'],
                                'full_name': _fullNameController.text,
                                'email': _emailController.text,
                                'phone_number': _phoneController.text,
                                'date_of_visit': _dateOfVisitController.text,
                                'number_of_adults':
                                    _numberOfAdultsController.text,
                                'number_of_children':
                                    _numberOfChildrenController.text,
                                'ticket_type': _selectedTicketType,
                                'visitor_name':
                                    _visitorNameController.text, // Visitor Name
                                'visitor_age':
                                    _visitorAgeController.text, // Visitor Age
                                'visitor_email': _visitorEmailController
                                    .text, // Visitor Email
                                'card_number':
                                    _cardNumberController.text, // Card Number
                                'cvv': _cvvController.text, // CVV
                                'expiry_date':
                                    _expiryDateController.text, // Expiry Date
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
                              _visitorNameController
                                  .clear(); // Clear visitor name
                              _visitorAgeController
                                  .clear(); // Clear visitor age
                              _visitorEmailController
                                  .clear(); // Clear visitor email
                              _cardNumberController
                                  .clear(); // Clear card number
                              _cvvController.clear(); // Clear CVV
                              _expiryDateController
                                  .clear(); // Clear expiry date

                              setState(() {
                                _selectedTicketType = "None";
                              });

                              // Navigate to ConfirmTicketsScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmTicketsScreen(
                                    bookingData: bookingDetails,
                                    bookingDetails:
                                        bookingDetails, // Update this line
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
                              content:
                                  Text('Please correct the errors in the form'),
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
                        backgroundColor: const Color.fromARGB(255, 42, 88, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
